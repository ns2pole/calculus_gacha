export const starterQuickRepliesSchema = {
  type: "object",
  properties: {
    quickReplies: {
      type: "array",
      description: "3-5 starter questions for this problem when the student first opens AI chat.",
      items: {
        type: "object",
        properties: {
          label: {
            type: "string",
            description: "Short chip label without LaTeX.",
          },
          sendText: {
            type: "string",
            description: "Optional fuller question sent when tapped.",
          },
          actionId: {
            type: "string",
            description: "Optional machine-readable id (hint, approach_only, first_step, etc.).",
          },
        },
        required: ["label"],
      },
    },
  },
  required: ["quickReplies"],
};
