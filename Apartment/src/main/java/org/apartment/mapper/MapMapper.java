package org.apartment.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apartment.domain.AptVO;

public interface MapMapper {

	public AptVO getXY(int apt_seq);
}
