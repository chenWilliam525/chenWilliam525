package com.example.controller;

import com.example.common.Result;
import com.example.entity.Complaint;
import com.example.entity.Fixed;
import com.example.service.ComplaintService;
import com.example.service.FixedService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


@RestController
@RequestMapping("/fixed")
public class FixedController {

    @Resource
    private FixedService fixedService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Fixed fixed) {
        fixedService.add(fixed);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        fixedService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        fixedService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Fixed fixed) {
        fixedService.updateById(fixed);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Fixed fixed = fixedService.selectById(id);
        return Result.success(fixed);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Fixed fixed ) {
        List<Fixed> list = fixedService.selectAll(fixed);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Fixed fixed,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Fixed> page = fixedService.selectPage(fixed, pageNum, pageSize);
        return Result.success(page);
    }

}