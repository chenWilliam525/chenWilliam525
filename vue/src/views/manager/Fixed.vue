<template>
  <div>
    <div class="table">
      <el-table :data="tableData" stripe>
        <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
        <el-table-column prop="content" label="发帖内容" width="500px" show-overflow-tooltip></el-table-column>
        <el-table-column prop="time" label="发帖时间" show-overflow-tooltip></el-table-column>
        <el-table-column prop="name" label="业主姓名"></el-table-column>

        <el-table-column label="操作" width="180" align="center">
          <template v-slot="scope">
            <el-button plain type="danger" size="mini" @click="del(scope.row.id)">删除</el-button>
<!--            <el-button plain type="primary" size="mini" @click="getReplies(scope.row.number)">查看回复</el-button>-->
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

    <!-- 回复列表对话框 -->
    <el-dialog :visible.sync="dialogVisible" title="回复内容">
      <el-table :data="replies" stripe>
        <el-table-column prop="username" label="回帖人账号" width="150"></el-table-column>
        <el-table-column prop="name" label="回帖人姓名" width="150"></el-table-column>
        <el-table-column prop="time" label="回帖时间" width="150"></el-table-column>
        <el-table-column prop="content" label="回帖内容"></el-table-column>
      </el-table>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">关闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Fixed",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dialogVisible: false,    // 控制查看回复对话框显示与隐藏
      replies: [],            // 存储与该帖子相关的所有回复
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/fixed/delete/' + id).then(res => {
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
      this.$request.get('/fixed/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },

    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },

    // 获取该帖子所有的评论
    getReplies(postNumber) {
      this.$request.get('/reply/selectRepliesByNumber', {
        params: {
          number: postNumber
        }
      }).then(res => {
        if (res.code === '200') {
          this.replies = res.data;   // 存储获取的回复
          this.dialogVisible = true;  // 打开回复的对话框
        } else {
          this.$message.error(res.msg);
        }
      })
    },
  }
}
</script>

<style scoped>
.pagination {
  margin-top: 20px;
  text-align: center;
}
</style>
