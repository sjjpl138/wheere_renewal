package kr.ac.kumoh.sjjpl138.wheere.route;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Route {

    @Id @Column(name = "ROUTE_ID")
    private Long id;

    @OneToMany(mappedBy = "route", cascade = CascadeType.REMOVE)
    private List<Route> buses = new ArrayList<>();
}
