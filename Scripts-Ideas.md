# Bash Scripts Ideas

1. **Random Password Generator**
    - Input
        - password length
            - optional
            - default length 10
        - how many different password to print
            - optional
            - default passwords 5
    - Output
        - N different encrypted passwords
2. **File Encrypter/Decrypter**
    - Input
        - choose encrypt or decrypt
        - file path
    - Output
        - Encrypted or Decrypted file
3. **Port Scanner [without using nmap]**
    - Input
        - URL
        - port range
            - optional
            - default all ports
        - delay in milliseconds
            - optional
            - default is 60
        - show all ports result, or open ports only
            - optional
            - default open ports only
    - Output
        - open ports in the specified website only or all ports with it’s state [open/closed]
4. **Backup script**
    - Input
        - list of files paths to backup (if)
        - path to place the backup in (of)
            - optional
            - default is “.”
    - Output
        - archive in $of contains all the files in the input list
        - archive named by the date and time
    - Bonus
        - Create a cronjob to run the script in a specific time every week/day
5. **Renamer**
    - Input
        - path to a dir containing series episodes or lectures
        - initial name (init)
    - Output
        - rename all the files in this format $init_i where i is an incrementing number sorted by date/time
6. **Crack /etc/shadow using John**
    - Input
        - path to a word-list
            - optional
            - default is rockyou.txt [or any other wordlist]
    - Output
        - the cracked user passwords from /etc/shadow in a file
    - Restrictions
        - check if you can read /etc/shadow
        - check if /etc/shadow exists
7. **Youtube to mp3** 
    - Input
        - Youtube URL
    - Output
        - downloaded video but converted to mp3
8. **Auto-update function**
    - Input
        - none
    - Output
        - upload the script on GitHub, and check if there are any differences between the existed file and the remote one if any : download the remote file and replace it with the local one
        - print if the file changed or not
        - print the URL of the github repo.
    - Restrictions
        - make it as a function in order to reuse it in other scripts
        - 
9. **Lyrics Grepper**
    - Input
        - URL of the song or play-list of songs on youtube
        - output the lyrics in the terminal
            - optional
    - Output
        - song lyrics in a file with the song name

10. **Search Script**
    - Arguments
        - There are two inputs, either:
            - A keyword and a path to a text file

                (e.g.)    string  /home/user/Documents/File.txt

            - A keyword and a path to a directory

                (e.g.)    string  /home/user/Documents

    - Options
        - (-i) : Ignore cases (upper case and lower case letters)
        - (-r) : Search recursively (Only used when the input is a keyword and a directory)
        - (-t) : When the input is a keyword and a directory search inside the text files in that directory (not the names of the files inside that directory)
    - Output
        - There are three cases of output
            - When the input is a keyword and a path to a text file:

                Print the occurrences of that keyword in the given text file.

            - When the input is a keyword and a path to a directory (without option -t):

                Print the occurrences of that keyword in the **names** of the files located in the given directory

            - When the input is a keyword and a path to a directory (with option -t):

                Print the occurrences of that keyword **within the text files** located in the given directory
                
11. **Sermov Fetcher**
    - Input
        - Movie or Series name
    - Output
        - IMDb rating, director and year of release 
    - Notes 
        - Sermov stands for Series and Movies
        - The output may include genres, storyline and cast names. 

## Resources

- [how to crack shadow file](https://null-byte.wonderhowto.com/how-to/crack-shadow-hashes-after-getting-root-linux-system-0186386/)
- [cclive - tool for downloading media from YouTube](http://cclive.sourceforge.net/)
- [ffmpeg - A complete, cross-platform solution to record, convert and stream audio and video.](https://ffmpeg.org/)
- [youtube video downloader tool](https://itsfoss.com/download-youtube-linux/)
