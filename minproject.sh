read -p " name: " name
read -p " shift: " shift
read -p " team: " team

file_name=$(date +%Y-%m-%d-%H%M%S)

jq -n --arg name "$name" --arg shift "$shift" --arg team "$team" '{  "shift": $shift , "name": $name, "team" : $team }' > employee_records/record_$file_name.json






