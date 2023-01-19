package kr.ac.kumoh.sjjpl138.wheere.driver;

import kr.ac.kumoh.sjjpl138.wheere.BaseTimeEntity;
import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Driver extends BaseTimeEntity {

    @Id @Column(name = "DRIVER_ID")
    private String id;

    @OneToOne
    @JoinColumn(name = "BUS_ID")
    private Bus bus;

    private String username;

    private double ratingScore;

    private int ratingCnt;

    public void calculateRating(double rating) {
        double sum = ratingCnt * ratingScore + rating;
        this.ratingCnt++;
        this.ratingScore = sum / ratingCnt;
    }

    public void assignBus(Bus bus) {
        this.bus = bus;
    }
}
