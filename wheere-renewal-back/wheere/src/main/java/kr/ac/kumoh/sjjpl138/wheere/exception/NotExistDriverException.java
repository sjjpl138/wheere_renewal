package kr.ac.kumoh.sjjpl138.wheere.exception;

public class NotExistDriverException extends RuntimeException{
    public NotExistDriverException() {
        super();
    }

    public NotExistDriverException(String message) {
        super(message);
    }
}
