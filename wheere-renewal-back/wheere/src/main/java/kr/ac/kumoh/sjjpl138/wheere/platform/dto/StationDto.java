package kr.ac.kumoh.sjjpl138.wheere.platform.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import lombok.Data;

@Data
public class StationDto {
        @JsonProperty("sId")
        private Long sId;
        @JsonProperty("sName")
        private String sName;
        @JsonProperty("sSeq")
        private int sSeq;

        public StationDto(Platform platform) {
                this.sId = platform.getStation().getId();
                this.sName = platform.getStation().getName();
                this.sSeq = platform.getStationSeq();
        }
}
