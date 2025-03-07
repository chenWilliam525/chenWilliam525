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

        <el-table-column prop="username" label="账号" width="200" align="center"></el-table-column>
        <el-table-column prop="password" label="密码" width="200" align="center"></el-table-column>


        <!-- 处理状态 -->
        <el-table-column prop="status" label="处理状态">
          <template v-slot="scope">
            <!-- 显示 status 的值 -->
            <el-tag type="success" v-if="scope.row.status === '已同意'">已同意</el-tag>
            <el-tag type="danger" v-else-if="scope.row.status === '已拒绝'">已拒绝</el-tag>
            <el-tag type="warning" v-else-if="scope.row.status === '待审核'">待审核</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="操作" width="180" align="center">
          <template v-slot="scope">
            <el-button
                    plain
                    type="success"
                    @click="handleAgree(scope.row)"
                    size="mini"
                    :disabled="scope.row.status === '已同意' ">
              同意
            </el-button>
            <el-button
                    plain
                    type="danger"
                    @click="handleReject(scope.row)"
                    size="mini"
                    :disabled="scope.row.status === '已同意' || scope.row.status === '已拒绝'">
              拒绝
            </el-button>
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
  name: "Examine",
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
    // 数据加载方法，分页查询
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum;
      this.$request.get('/user/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          status: this.status,
        }
      }).then(res => {
        this.tableData = res.data?.list;
        this.total = res.data?.total;
      });
    },

    // 重置查询
    reset() {
      this.status = null;
      this.load(1);
    },

    // 处理分页变化
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },

    // 同意操作
    handleAgree(row) {
      this.$confirm('您确定同意吗？', '确认同意', { type: "info" }).then(() => {
        let data = JSON.parse(JSON.stringify(row));
        data.status = '已同意';  // 修改状态为已同意

        this.updateStatus(data);
      }).catch(() => {
        // 取消操作
      });
    },

    // 拒绝操作
    handleReject(row) {
      this.$confirm('您确定拒绝吗？', '确认拒绝', { type: "warning" }).then(() => {
        let data = JSON.parse(JSON.stringify(row));
        data.status = '已拒绝';  // 修改状态为已拒绝

        this.updateStatus(data);
      }).catch(() => {
        // 取消操作
      });
    },

    // 更新状态方法
    updateStatus(data) {
      this.$request.put('/user/update', data)
        .then(res => {
          if (res.code === '200') {
            this.$message.success('操作成功');
            this.load(this.pageNum);  // 刷新数据
          } else {
            this.$message.error(res.msg);  // 错误提示
          }
        }).catch(() => {
          this.$message.error('处理失败');
        });
    }
  }
}
</script>
