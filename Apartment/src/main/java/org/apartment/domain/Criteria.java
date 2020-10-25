package org.apartment.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@ToString
@Setter
@Getter
public class Criteria {

  private int pageNum;
  private int amount;
  
//  private String type;
//  private String keyword;

  public Criteria() {
    this(1, 8);
  }

  public Criteria(int pageNum, int amount) {
    this.pageNum = pageNum;
    this.amount = amount;
  }
  
//  public String[] getTypeArr() {
//    
//    return type == null? new String[] {}: type.split("");
//  }
}
