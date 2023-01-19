package kr.ac.kumoh.sjjpl138.wheere.driver.dto;

import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import lombok.Data;

@Data
public class StationDto {
        private Long sId;
        private String sName;
        private int sSeq;

        public StationDto(Platform platform) {
                this.sId = platform.getStation().getId();
                this.sName = platform.getStation().getName();
                this.sSeq = platform.getStationSeq();
        }
}
