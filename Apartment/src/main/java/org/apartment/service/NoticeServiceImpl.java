package org.apartment.service;

import java.util.List;

import org.apartment.domain.NoticeCriteria;
import org.apartment.domain.NoticeVO;
import org.apartment.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeServiceImpl implements NoticeService {

	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;

	@Override
	public void register(NoticeVO notice) {
		log.info("register......" + notice);
		mapper.insertNotice(notice);

	}

	@Override
	public NoticeVO get(int noticeSeq) {
		log.info("get..................... " + noticeSeq);

		return mapper.readNotice(noticeSeq);
	}

	@Override
	public boolean modify(NoticeVO notice) {
		log.info("modify........." + notice);
		
		return mapper.updateNotice(notice) == 1;
	}

	@Override
	public boolean remove(int noticeSeq) {
		log.info("delete............................" + noticeSeq);
		return mapper.deleteNotice(noticeSeq) == 1;
	}

	@Override
	public List<NoticeVO> getList(NoticeCriteria cri, int aptSeq) {
		log.info("getList...........with criteria.........." + cri + aptSeq);
		return mapper.getListWithPaging(cri, aptSeq);
	}

	@Override
	public int getTotal(NoticeCriteria cri, int aptSeq) {
		log.info("get total Count");
		return mapper.getTotalCount(cri, aptSeq);
	}

	@Override
	public boolean plusCnt(int noticeSeq) {
		log.info(" count up : "+ noticeSeq);
		
		return mapper.plusCnt(noticeSeq);
	}

	

}