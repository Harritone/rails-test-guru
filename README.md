# Test Guru project

## List of enteties

* User
* Quiz
* Question
* Answer


## Development in Docker:
* To build an image execute:
    ```console
        docker build . -t test-guru
    ```
* To run application in a container execute:
    ```console
        docker run -it -p 3000:3000 -v ${PWD}:/app test-guru
    ```
* To run bash in a container execute:
    ```console
       docker run -it -v ${PWD}:/app test-guru bash 
    ```
