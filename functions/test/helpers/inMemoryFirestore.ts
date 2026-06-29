type DocData = Record<string, unknown>;

class InMemoryDocSnapshot {
  constructor(
    readonly id: string,
    private readonly data: DocData | null,
  ) {}

  get exists(): boolean {
    return this.data != null;
  }

  get(field: string): unknown {
    return this.data?.[field];
  }
}

class InMemoryQuerySnapshot {
  constructor(readonly docs: InMemoryDocSnapshot[]) {}
}

class InMemoryDocumentReference {
  constructor(
    private readonly store: Map<string, DocData>,
    readonly path: string,
    readonly id: string,
  ) {}

  async get(): Promise<InMemoryDocSnapshot> {
    return new InMemoryDocSnapshot(this.id, this.store.get(this.path) ?? null);
  }

  async set(data: DocData, options?: {merge?: boolean}): Promise<void> {
    const existing = this.store.get(this.path) ?? {};
    this.store.set(
      this.path,
      options?.merge === true ? {...existing, ...data} : {...data},
    );
  }

  collection(name: string): InMemoryCollectionReference {
    return new InMemoryCollectionReference(this.store, `${this.path}/${name}`);
  }
}

class InMemoryCollectionReference {
  constructor(
    private readonly store: Map<string, DocData>,
    private readonly path: string,
  ) {}

  doc(id: string): InMemoryDocumentReference {
    return new InMemoryDocumentReference(this.store, `${this.path}/${id}`, id);
  }

  async get(): Promise<InMemoryQuerySnapshot> {
    const prefix = `${this.path}/`;
    const docs: InMemoryDocSnapshot[] = [];

    for (const [docPath, data] of this.store.entries()) {
      if (!docPath.startsWith(prefix)) continue;
      const remainder = docPath.slice(prefix.length);
      if (remainder.includes("/")) continue;
      docs.push(new InMemoryDocSnapshot(remainder, data));
    }

    return new InMemoryQuerySnapshot(docs);
  }
}

class InMemoryTransaction {
  private readonly pendingSets = new Map<string, DocData>();

  constructor(private readonly store: Map<string, DocData>) {}

  async get(
    ref: InMemoryDocumentReference,
  ): Promise<InMemoryDocSnapshot> {
    const pending = this.pendingSets.get(ref.path);
    if (pending != null) {
      return new InMemoryDocSnapshot(ref.id, pending);
    }
    return ref.get();
  }

  set(
    ref: InMemoryDocumentReference,
    data: DocData,
    options?: {merge?: boolean},
  ): void {
    const existing = this.pendingSets.get(ref.path) ??
      this.store.get(ref.path) ??
      {};
    this.pendingSets.set(
      ref.path,
      options?.merge === true ? {...existing, ...data} : {...data},
    );
  }

  commit(): void {
    for (const [path, data] of this.pendingSets.entries()) {
      this.store.set(path, data);
    }
  }
}

class InMemoryFirestore {
  private readonly store = new Map<string, DocData>();

  collection(name: string): InMemoryCollectionReference {
    return new InMemoryCollectionReference(this.store, name);
  }

  async runTransaction<T>(
    updateFunction: (transaction: InMemoryTransaction) => Promise<T>,
  ): Promise<T> {
    const transaction = new InMemoryTransaction(this.store);
    const result = await updateFunction(transaction);
    transaction.commit();
    return result;
  }
}

export function createInMemoryFirestore(): FirebaseFirestore.Firestore {
  return new InMemoryFirestore() as unknown as FirebaseFirestore.Firestore;
}
