package org.apartment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apartment.domain.Criteria;
import org.apartment.domain.MarketBoardVO;

public interface MarketBoardMapper {
	
	@Select("select * from market_product")
	public List<MarketBoardVO> getList();
	
	public void insertMarketProduct(MarketBoardVO market);
	
	public List<MarketBoardVO> listMarketProduct();
	
	public MarketBoardVO detailMarketProduct(int seq);
	
	public int deleteMarketProduct(int seq);
	
	public int updateMarketProduct(MarketBoardVO market);
	
	public List<MarketBoardVO> getListWithPaging(@Param("cri") Criteria cri,@Param("apt_seq") int apt_seq);
	
	public int getTotalCount(Criteria cri);
}	
