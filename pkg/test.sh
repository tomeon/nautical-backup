#!/bin/bash

bash /entry.sh

echo "Running tests..."

test_cron() {
    # Expected output
    EXPECTED_OUTPUT="$CRON_SCHEDULE bash /app/backup.sh"

    # Run the command and capture its output
    ACTUAL_OUTPUT=$(crontab -l | grep bash)

    # Compare the actual output to the expected output
    if [ "$ACTUAL_OUTPUT" == "$EXPECTED_OUTPUT" ]; then
        echo "Test Passed: Output matches expected output."
    else
        echo "Test Failed: Output does not match expected output."
        echo "Expected: $EXPECTED_OUTPUT"
        echo "Got: $ACTUAL_OUTPUT"
        exit 1
    fi
}

test_bash() {
    EXPECTED_OUTPUT="/bin/bash"
    ACTUAL_OUTPUT=$(which bash)

    # Compare the actual output to the expected output
    if [ "$ACTUAL_OUTPUT" == "$EXPECTED_OUTPUT" ]; then
        echo "Test Passed: Output matches expected output."
    else
        echo "Test Failed: Output does not match expected output."
        echo "Expected: $EXPECTED_OUTPUT"
        echo "Got: $ACTUAL_OUTPUT"
        exit 1
    fi

    # Use 'bash --version' to check if it returns something
    if [[ $(bash --version) ]]; then
        echo "Test Passed: 'bash --version' returns a value."
    else
        echo "Test Failed: 'bash --version' did not return a value."
        exit 1
    fi
}

test_rsync() {
    EXPECTED_OUTPUT="/usr/bin/rsync"
    ACTUAL_OUTPUT=$(which rsync)

    # Compare the actual output to the expected output
    if [ "$ACTUAL_OUTPUT" == "$EXPECTED_OUTPUT" ]; then
        echo "Test Passed: Rsync is installed"
    else
        echo "Test Failed: Output does not match expected output."
        echo "Expected: $EXPECTED_OUTPUT"
        echo "Got: $ACTUAL_OUTPUT"
        exit 1
    fi

    
    # Use 'rsync --version' to check if it returns something
    if [[ $(rsync --version) ]]; then
        echo "Test Passed: 'rsync --version' returns a value."
    else
        echo "Test Failed: 'rsync --version' did not return a value."
        exit 1
    fi
}

test_jq() {
    EXPECTED_OUTPUT="/usr/bin/jq"
    ACTUAL_OUTPUT=$(which jq)

    # Compare the actual output to the expected output
    if [ "$ACTUAL_OUTPUT" == "$EXPECTED_OUTPUT" ]; then
        echo "Test Passed: QJ is installed"
    else
        echo "Test Failed: Output does not match expected output."
        echo "Expected: $EXPECTED_OUTPUT"
        echo "Got: $ACTUAL_OUTPUT"
        exit 1
    fi

    # Use 'jq --help' to check if it returns something
    if [[ $(jq --help) ]]; then
        echo "Test Passed: 'jq --help' returns a value."
    else
        echo "Test Failed: 'jq --help' did not return a value."
        exit 1
    fi
}

test_tz(){
    EXPECTED_OUTPUT="America/Los_Angeles"
    ACTUAL_OUTPUT=$(echo $TZ)

    # Compare the actual output to the expected output
    if [ "$ACTUAL_OUTPUT" == "$EXPECTED_OUTPUT" ]; then
        echo "Test Passed: Output matches expected output."
    else
        echo "Test Failed: Output does not match expected output."
        echo "Expected: $EXPECTED_OUTPUT"
        echo "Got: $ACTUAL_OUTPUT"
        exit 1
    fi

    # Use 'date | grep PDT' to check if it returns something
    if [[ $(date | grep PDT) ]]; then
        echo "Test Passed: 'date | grep PDT' returns a value."
    else
        echo "Test Failed: 'date | grep PDT' did not return a value."
        exit 1
    fi
}
test_cron
test_tz
test_bash
test_rsync
test_jq
echo "All tests passed!"
