#!/bin/bash

# Set your master passcode here
CORRECT_PASSCODE="secret123"

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
            echo ""
            echo "╔════════════════════════════════════════╗"
            echo "║   ✓ ACCESS GRANTED                     ║"
            echo "╠════════════════════════════════════════╣"
            echo "║   Welcome! You have successfully       ║"
            echo "║   entered the correct passcode.        ║"
            echo "║   Access to restricted area granted.   ║"
            echo "╚════════════════════════════════════════╝"
            break
        else
            echo "Access denied. Try again."
        fi
    fi
done
