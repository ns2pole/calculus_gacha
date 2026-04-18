import re

# Read IDs from file
with open('ids.txt', 'r') as f:
    ids = [line.strip() for line in f if line.strip()]

with open('lib/problems/unit/problems.dart', 'r') as f:
    content = f.read()

new_content = ""
current_id_index = 0
last_pos = 0

# Find all occurrences of UnitProblem(
for match in re.finditer(r'UnitProblem\(', content):
    start, end = match.span()
    new_content += content[last_pos:end]
    
    # Check if we have IDs left
    if current_id_index < len(ids):
        new_content += f'\n    id: "{ids[current_id_index]}",'
        current_id_index += 1
        
    last_pos = end

new_content += content[last_pos:]

with open('lib/problems/unit/problems_new.dart', 'w') as f:
    f.write(new_content)


