package com.example.controller;

import com.example.common.Result;
import com.example.entity.Complaint;
import com.example.service.ComplaintService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 公告信息表前端操作接口
 **/
@RestController
@RequestMapping("/complaint")
public class ComplaintController {

    @Resource
    private ComplaintService complaintService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Complaint complaint) {
        complaintService.add(complaint);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        complaintService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        complaintService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Complaint complaint) {
        complaintService.updateById(complaint);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Complaint complaint = complaintService.selectById(id);
        return Result.success(complaint);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Complaint complaint ) {
        List<Complaint> list = complaintService.selectAll(complaint);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Complaint complaint,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Complaint> page = complaintService.selectPage(complaint, pageNum, pageSize);
        return Result.success(page);
    }

}