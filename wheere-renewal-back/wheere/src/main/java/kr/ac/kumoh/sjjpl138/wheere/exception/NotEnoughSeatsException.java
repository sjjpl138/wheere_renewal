package kr.ac.kumoh.sjjpl138.wheere.exception;

public class NotEnoughSeatsException extends RuntimeException{
    public NotEnoughSeatsException() {
        super();
    }

    public NotEnoughSeatsException(String message) {
        super(message);
    }
}
