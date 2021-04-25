package org.apartment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apartment.domain.NoticeCriteria;
import org.apartment.domain.NoticeVO;
public interface NoticeMapper {

	// @Select("select * from notice where notice_seq > 0")
	public List<NoticeVO> getList();

	public List<NoticeVO> getListWithPaging(@Param("cri") NoticeCriteria cri,@Param("aptSeq") int aptSeq);

	public void insertNotice(NoticeVO notice);

	public NoticeVO readNotice(int noticeSeq);

	public int deleteNotice(int noticeSeq);

	public int updateNotice(NoticeVO notice);
	
	public int getTotalCount(@Param("cri") NoticeCriteria cri,@Param("aptSeq") int aptSeq);
	
	public boolean plusCnt(int noticeSeq);

}
