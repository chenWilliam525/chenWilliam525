package com.example.mapper;

import com.example.entity.Complaint;

import java.util.List;

/**
 * 操作complaint相关数据接口
*/
public interface ComplaintMapper {

    /**
      * 新增
    */
    int insert(Complaint complaint);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Complaint complaint);

    /**
      * 根据ID查询
    */
    Complaint selectById(Integer id);

    /**
      * 查询所有
    */
    List<Complaint> selectAll(Complaint complaint);


    Complaint selectByName(String name);
}