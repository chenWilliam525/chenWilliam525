package com.example.mapper;

import com.example.entity.Examine;

import java.util.List;

/**
 * 操作examine相关数据接口
*/
public interface ExamineMapper {

    /**
      * 新增
    */
    int insert(Examine examine);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Examine examine);

    /**
      * 根据ID查询
    */
    Examine selectById(Integer id);

    /**
      * 查询所有
    */
    List<Examine> selectAll(Examine examine);


    Examine selectByName(String name);
}