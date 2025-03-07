package com.example.mapper;

import com.example.entity.Post;

import java.util.List;

/**
 * 操作post相关数据接口
*/
public interface PostMapper {

    /**
      * 新增
    */
    int insert(Post post);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Post post);

    /**
      * 根据ID查询
    */
    Post selectById(Integer id);

    /**
      * 查询所有
    */
    List<Post> selectAll(Post post);

}