import sys
import time

while True:
    # Get the current date and time in YYYYMMDDHHMMSS format
    date_time = time.strftime("%Y%m%d%H%M%S")

    try:
        # Open a file for writing and create a file object named "log_file"
        log_file = open("wtfLog" + date_time + ".txt", "w")

        # Redirect stdout to the log file
        sys.stdout = log_file

        # Print some text to the log file
        print("This text will be written to the log file")

        # Wait for user input
        user_input = input("Enter 'wtFmj' to stop the logging script: ")

        # If the user input is 'wtFmj', break out of the loop to stop the script
        if user_input == "wtFmj":
            break

    except Exception as e:
        # If an exception occurs, print the error message
        print(e)

    finally:
        # Close the log file
        log_file.close()
