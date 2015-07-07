## Localization

### Objectives

Develop a mechanism that enables a program to display its interface in multiple languages, depending on how it is configured.
A GUI is not mandatory, it is sufficient to develop a command line program that will print some strings in one language or
another (depending on the command line arguments). Ex: myProg.exe /FR will display French strings, while myProg.exe /EN will display English strings.

### Requirements

- The program must use Unicode for all string-related procedures
- The strings for each language must be loaded from a file
- The program must display the paths to the special folders in the system on which it is ran (for the currently logged on user):
	* Program Files
	* My Documents
	* On POSIX systems, look for the home directory; if you're running a fancy desktop environment, get the paths to the Photos and Music folder
- The program must display the current date and time using the system's regional settings formatting

### Description

Generator steps:
- First we generate a random string with a secret string.
- Then we encrypt that key using the way of public key cryptography.
- Then encode the key in base64.
- Save the encoded key in a file, later to be read.

Verifier steps:
- Reverse the base64 encoding.
- Decrypt the key using public key.
- Check the number and return a boolean value.

### Conclusion

After making this laboratory work I learned more about internalization and use of different tools
in order to achieve the best results.
