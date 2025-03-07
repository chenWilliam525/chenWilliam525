<template>
  <div>
    <div class="search">
      <el-input placeholder="请输入状态查询" style="width: 200px" v-model="status"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" stripe>
        <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
        <el-table-column prop="content" label="反馈内容" width="500px" show-overflow-tooltip></el-table-column>
        <el-table-column prop="time" label="提交时间" show-overflow-tooltip></el-table-column>
        <el-table-column prop="name" label="业主姓名"></el-table-column>
        <el-table-column prop="status" label="处理状态">
          <template v-slot="scope">
            <el-tag type="success" v-if="scope.row.status === '已处理'">已处理</el-tag>
            <el-tag type="danger" v-else>待处理</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="操作" width="180" align="center">
          <template v-slot="scope">
            <el-button plain type="primary" @click="handleComplaint(scope.row)" size="mini" :disabled="scope.row.status === '已处理'">处理</el-button>
            <el-button plain type="danger" size="mini" @click=del(scope.row.id)>删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total">
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Complaint",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      status: null
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/complaint/delete/' + id).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/complaint/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          status: this.status,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total

      })
    },
    reset() {
      this.status = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleComplaint(row) {
      let data = JSON.parse(JSON.stringify(row))
      data.status = '已处理'
      this.$request.put('/complaint/update', data).then(res => {
        if (res.code === '200') {
          this.$message.success('处理成功')
          this.load(this.pageNum)
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
