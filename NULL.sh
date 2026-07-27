#!/bin/bash

# Set your master passcode here
CORRECT_PASSCODE="pgtiam"

# Array of wrong synonyms (will be shuffled)
WRONG_SYNONYMS=(
    "wrong"
    "incorrect"
    "invalid"
    "denied"
    "rejected"
)

# Shuffle the array
shuffle_array() {
    local array=("$@")
    for ((i=${#array[@]}-1; i>0; i--)); do
        local j=$((RANDOM % (i+1)))
        local temp=${array[i]}
        array[i]=${array[j]}
        array[j]=$temp
    done
    echo "${array[@]}"
}

# Shuffle the synonyms
SHUFFLED=($(shuffle_array "${WRONG_SYNONYMS[@]}"))

# Secret counter
counter=0
max_counter=5

echo "=== PASSCODE REQUIRED ==="
echo ""

while true; do
    read -sp "Enter passcode: " user_input
    echo ""
    
    # If counter hasn't reached max, tell them it's the current synonym
    if [ $counter -lt $max_counter ]; then
        echo "The password is ${SHUFFLED[$counter]}"
        
        # Check if they typed the correct synonym
        if [ "$user_input" = "${SHUFFLED[$counter]}" ]; then
            counter=$((counter + 1))
        fi
    else
        # After 5 cycles, check for actual password
        if [ "$user_input" = "$CORRECT_PASSCODE" ]; then
            # Check if current year is 2030 or later
            current_year=$(date +%Y)
            if [ "$current_year" -ge 2030 ]; then
                echo ""
                echo "╔════════════════════════════════════════╗"
                echo "║   ✓ ACCESS GRANTED                     ║"
                echo "╠════════════════════════════════════════╣"
                echo "║  You solved the puzzle! Yay!           ║"
                echo "║  Or did you?                           ║"
                echo "╚════════════════════════════════════════╝"
                break
            else
                echo "Access denied. The system time must be set to 2030 or later."
                echo "Current year: $current_year"
            fi
        else
            echo "Access denied. Try again."
        fi
    fi
done
#
