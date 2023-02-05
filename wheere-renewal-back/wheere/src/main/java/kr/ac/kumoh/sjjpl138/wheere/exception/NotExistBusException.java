package kr.ac.kumoh.sjjpl138.wheere.exception;

public class NotExistBusException extends RuntimeException{
    public NotExistBusException() {
        super();
    }

    public NotExistBusException(String message) {
        super(message);
    }
}
