package org.apartment.service;

import java.util.List;

import org.apartment.domain.Criteria;
import org.apartment.domain.MarketReplyVO;
import org.apartment.mapper.MarketReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
public class MarketReplyServiceImpl implements MarketReplyService{
	
	@Setter(onMethod_=@Autowired)
	private MarketReplyMapper mapper;

	@Override
	public int ReplyRegister(MarketReplyVO vo) {
		// TODO Auto-generated method stub
		log.info("reply register角青");
		return mapper.marketReplyInsert(vo);
	}

	@Override
	public MarketReplyVO ReplyGet(int replyNo) {
		// TODO Auto-generated method stub
		log.info("reply get角青");
		return mapper.marketReplyRead(replyNo);
	}

	@Override
	public int ReplyModify(MarketReplyVO vo) {
		// TODO Auto-generated method stub
		log.info("reply modify角青");
		return mapper.marketReplyUpdate(vo);
	}

	@Override
	public int ReplyRemove(int replyNo) {
		// TODO Auto-generated method stub
		log.info("reply remove角青");
		return mapper.marketReplyDelete(replyNo);
	}

	@Override
	public List<MarketReplyVO> ReplyGetList(Criteria cri, int seq) {
		// TODO Auto-generated method stub
		log.info("reply getlist角青");
		return mapper.getListWithPaging(cri,seq);
	}

}
