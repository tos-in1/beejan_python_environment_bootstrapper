#!/bin/bash

# If commands encounters any error, stop the scripts
set -e

# >>>>>>>>>>>>>>>>>>> Create Project Directory <<<<<<<<<<<<<<<<<<<

DIRECTORY="$(pwd)"

# >>>>>>>>>>>>>>>>>>> Create Log File In Directory <<<<<<<<<<<<<<<<<<
mkdir -p $DIRECTORY/logs

LOG_FILE="$DIRECTORY/logs/setup.log" # this would create a new setup.log

# Defining color variables
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
WHITE="\e[37m"
RESET="\e[0m"

# >>>>>>>>>>>>>>>>>>> Create unified CLI print / log message function <<<<<<<<<<<<<<<<<<

logging_msg() {
        local LEVEL=$1
        local MESSAGE=$2
        local COLOR

        # Selecting colour based on level
        case "$LEVEL" in
                INFO) COLOR=$BLUE;;
                SUCCESS) COLOR=$GREEN;;
                WARNING) COLOR=$YELLOW;;
                ERROR) COLOR=$RED;;
                *) COLOR=$WHITE;;
        esac

        # CLI message
        echo -e "${COLOR}[$LEVEL] $MESSAGE${RESET}"

        # Append message to Log File
        echo "$(date '+%Y-%m-%d %H:%M:%S') [$LEVEL] $MESSAGE" >> "$LOG_FILE"
}

# >>>>>>>>>>>> Get Version  <<<<<<<<<<<<
get_version() {
        # Version path 
        VERSION_FILE="$DIRECTORY/VERSION"

        if [ -f "$VERSION_FILE" ]; then
                VERSION=$(cat "$VERSION_FILE")
        else
                VERSION="v1.1"
                echo "$VERSION" > "$VERSION_FILE"
        fi
}

get_version

logging_msg "INFO" "Starting setup process..... Version: $VERSION...🛠️"

# ======================================================================
#                       STARTING STARTUP PROCESS
# ======================================================================


# ==================== CREATE PROJECT FUNCTION ===================

# >>>>>>>>>>>> Create or activate virtual environment  <<<<<<<<<<<<

create_venv() {
        VENV_PATH="$DIRECTORY/.venv"

        if [ -d  $VENV_PATH ]; then
                logging_msg "WARNING" "Virtual environment $VENV_PATH already exists.. Activating..."
                
                # Activating virtual envirinment
                source "$VENV_PATH/bin/activate" 
        else
                logging_msg "INFO" "Creating python virtual environment...."

                # Install venv package
                sudo apt install -y python3.12-venv
                python3 -m venv "$VENV_PATH"

                # Activate the newly created virtual environment
                source "$VENV_PATH/bin/activate"

                logging_msg "SUCCESS" "Virtual environment created and activated! ✅"
        fi
}


# >>>>>>>>>>>>>>>>>>> Upgrade or Install pip  <<<<<<<<<<<<<<<<<<<

upgrade_pip() {
        logging_msg "INFO" "Upgrading pip to the latest version....."
        python3 -m pip install --upgrade pip
        logging_msg "SUCCESS" "pip was upgraded sucessfully"
}


# >>>>>>>>>>>>>>>>>>>> Create an Empty .env File <<<<<<<<<<<<<<<<<<<<

create_env() {
    ENV_FILE="$DIRECTORY/.env"

    if [ -f "$ENV_FILE" ]; then
        logging_msg "WARNING" ".env file already exists"
    else
        touch "$ENV_FILE"
        logging_msg "SUCCESS" ".env successfully created!"
    fi
}


# >>>>>>>>>>>>>>>>>>> Create README.md File <<<<<<<<<<<<<<<<<<<<

create_readme() {
    README_FILE="$DIRECTORY/README.md"

    if [ -f "$README_FILE" ]; then
        logging_msg "WARNING" "README.md already exists"
    else
        cat <<EOF > "$README_FILE"
# New Python Project

This readme file was automatically generated with setup.sh and all project descrition should be written here.
EOF
        logging_msg "SUCCESS" "README.md created successfully!"
    fi
}


# >>>>>>>>>>>>>>>>> Create Required Package List  <<<<<<<<<<<<<<<<<<

req_package() {

        REQ_FILE="$DIRECTORY/requirement.txt"


        if [ -f "$REQ_FILE" ]; then
                logging_msg "WARNING" "$REQ_FILE already exists..."
        else
                touch "$REQ_FILE"
                logging_msg "INFO" "Creating $REQ_FILE file"

                cat <<EOF > "$REQ_FILE"

pandas
numpy>=2.0.0
requests
sqlalchemy
psycopg2-binary
python-dotenv
boto3
pyarrow
pydantic
EOF

                logging_msg "SUCCESS" "$REQ_FILE created successfully! ✅"
        fi
}


# >>>>>>>>>>>>>>>>>>> Create .gitignore File <<<<<<<<<<<<<<<<<<

gitignore() {
        GITIGNORE_FILE="$DIRECTORY/.gitignore"

        # Checking if gitignore exists in the path directory
        if [ -f "$GITIGNORE_FILE" ]; then
                logging_msg "WARNING" ".gitignore already existed in $GITIGNORE_FILE"
        else
                logging_msg "INFO" "Creating .gitignore... 🔃"
                cat <<EOF > "$GITIGNORE_FILE"
# Python cache
__pycache__/
*.pyc

# Virtual environment
.venv/

# Environment variable
.env

EOF

                logging_msg "SUCCESS" ".gitignore created successfully! ✅"
        fi
}


# >>>>>>>>>>>>>>>>> Create Install Package Function  <<<<<<<<<<<<<<<<<<

install_package() {
        REQ_FILE="$DIRECTORY/requirement.txt"

        if [ -f "$REQ_FILE" ]; then
                logging_msg "INFO" "Installing packages from $REQ_FILE...."
                pip install -r "$REQ_FILE"

                logging_msg "SUCCESS" "$REQ_FILE installed successfully!"
        else
                logging_msg "ERROR" "$REQ_FILE not found. Skipping, no installation...."
        fi

}

# >>>>>>>>>>>>>>>>>>>>>>>>>>> RUN THE FUNCTIONS  <<<<<<<<<<<<<<<<<<<<<<<<<

create_venv
upgrade_pip
create_env
create_readme
gitignore
req_package
install_package

# >>>>>>>>>>>>>>>>>>>>>>>>>>> ALL DONE!!  <<<<<<<<<<<<<<<<<<<<<<<<<

logging_msg "SUCCESS" "Setup completed successfully!! 🥳"
logging_msg "INFO" "Logs saved to log file"

