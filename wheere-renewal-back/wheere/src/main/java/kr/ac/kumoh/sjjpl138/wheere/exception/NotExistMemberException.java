package kr.ac.kumoh.sjjpl138.wheere.exception;

public class NotExistMemberException extends RuntimeException{
    public NotExistMemberException() {
        super();
    }

    public NotExistMemberException(String message) {
        super(message);
    }
}

