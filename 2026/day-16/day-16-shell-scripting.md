# Challenge Tasks
## Task 1: Your First Script
Create a file hello.sh
Add the shebang line #!/bin/bash at the top
Print Hello, DevOps! using echo
Make it executable and run it
chmod +x hello.sh
./hello.sh
<img width="1371" height="336" alt="image" src="https://github.com/user-attachments/assets/ff45b5a0-76c4-40d1-a1d5-01e4623605d0" />

Document: What happens if you remove the shebang line?

<img width="1380" height="192" alt="image" src="https://github.com/user-attachments/assets/5ee30037-f23b-45bb-924f-f2995ab0e6ba" />


## Task 2: Variables
Create variables.sh with:
A variable for your NAME
A variable for your ROLE (e.g., "DevOps Engineer")
Print: Hello, I am <NAME> and I am a <ROLE>
<img width="1492" height="365" alt="image" src="https://github.com/user-attachments/assets/02b4b8c9-ca3a-4db4-976c-d05ec3fb6d4a" />

Try using single quotes vs double quotes — what's the difference?
<img width="1140" height="408" alt="image" src="https://github.com/user-attachments/assets/28327e24-657d-45df-8603-482ba90e1389" />
<img width="1440" height="96" alt="image" src="https://github.com/user-attachments/assets/3881275b-7092-46b9-b76c-63617d3ed987" />

## Task 3: User Input with read
Create greet.sh that:
Asks the user for their name using read
Asks for their favourite tool
Prints: Hello <name>, your favourite tool is <tool>
<img width="1265" height="471" alt="image" src="https://github.com/user-attachments/assets/11a63447-03e2-47e0-a8de-d5e725e77b8d" />

<img width="1422" height="260" alt="image" src="https://github.com/user-attachments/assets/36a5a667-3f9a-451a-a318-059db799bb91" />
4. Direct Comparison: Prompt vs. Silent vs. TimedScenarioCode SnippetKey FeatureStandard Textread -p "Name: " nameDisplays prompt text inlinePasswords / Keysread -s -p "Key: " keyHides text on the screenYes / No Confirmationread -n 1 -p "[y/n]: " ansAdvances instantly after 1 keypressAutomated Fallbackread -t 3 -p "Wait: " waitAborts or moves on after 3 seconds
## Task 4: If-Else Conditions
Create check_number.sh that:

Takes a number using read
Prints whether it is positive, negative, or zero
Create file_check.sh that:
<img width="1046" height="712" alt="image" src="https://github.com/user-attachments/assets/29322671-54d2-4e10-9e81-402e21f4b4e3" />
<img width="1551" height="438" alt="image" src="https://github.com/user-attachments/assets/0b845e77-df2e-4074-b0a6-f943cc77d53c" />

Asks for a filename
Checks if the file exists using -f
Prints appropriate message
<img width="952" height="522" alt="image" src="https://github.com/user-attachments/assets/4a613339-cc3e-497c-8ffa-0dd014e6a575" />
<img width="1457" height="220" alt="image" src="https://github.com/user-attachments/assets/606f2d14-79dc-4e5a-913b-b01029663f3e" />

## Task 5: Combine It All
Create server_check.sh that:

Stores a service name in a variable (e.g., nginx, sshd)
Asks the user: "Do you want to check the status? (y/n)"
If y — runs systemctl status <service> and prints whether it's active or not
If n — prints "Skipped."
<img width="1268" height="658" alt="image" src="https://github.com/user-attachments/assets/1d0f678f-6b95-43f4-b1d3-1a4b453854d8" />

<img width="1492" height="522" alt="image" src="https://github.com/user-attachments/assets/2ee0c0ca-0272-41a7-afb9-ef68162d5e31" />
