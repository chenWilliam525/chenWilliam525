<template>
  <div class="container">
    <el-card class="notice-card" shadow="hover" style="width: 100%; max-width: 1000px; padding: 20px;">
      <div class="card-title">公告列表</div>

      <!-- 公告表格 -->
      <el-table :data="notices" border style="width: 100%" v-loading="loading">
        <el-table-column label="活动标题" prop="title" width="300px" :resizable="false">
        </el-table-column>
        <el-table-column label="发布时间" prop="time" width="0px" :resizable="false">
        </el-table-column>
        <el-table-column label="操作" width="150px" :resizable="false">
          <template slot-scope="scope">
            <el-button size="mini" @click="viewNotice(scope.row)" type="primary">查看</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 查看公告详情的对话框 -->
    <el-dialog :visible.sync="dialogVisible" width="60%" :before-close="handleClose">
      <span class="dialog-title">公告详情</span>
      <div class="dialog-body">
        <span class="dialog-title-normal">亲爱的业主朋友们：</span>
      </div>
      <div v-html="selectedNotice.content"></div>
      <!-- 在公告内容之后添加发布时间和幸福物业 -->
      <div class="dialog-footer-info">
        <span>{{ formattedTime }}</span> <br/>
        <span>{{time}}</span>
        <span>幸福物业</span>
      </div>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">关闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      notices: [],
      selectedNotice: {},
      loading: false,
      dialogVisible: false,
    };
  },
  created() {
    this.loadNotices();
  },
  methods: {
    loadNotices() {
      this.loading = true;
      this.$request.get('/notice/selectAll')
        .then(res => {
          if (res.code === '200') {
            this.notices = res.data || [];
          } else {
            this.$message.error('获取公告失败');
          }
        })
        .catch(err => {
          this.$message.error('请求失败，请稍后再试');
        })
        .finally(() => {
          this.loading = false;
        });
    },

    // 点击查看时，弹出公告详情
    viewNotice(row) {
      this.selectedNotice = row;
      this.dialogVisible = true;
    },

formatTime(time) {
  const date = new Date(time);
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const day = date.getDate().toString().padStart(2, '0');
  const hours = date.getHours().toString().padStart(2, '0');
  const minutes = date.getMinutes().toString().padStart(2, '0');
  const seconds = date.getSeconds().toString().padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
},

// 计算属性返回格式化后的时间
computed: {
  formattedTime() {
    return this.selectedNotice.time ? this.formatTime(this.selectedNotice.time) : '';
  }
},


    handleClose(done) {
      this.dialogVisible = false;
    }

  }
};
</script>

<style scoped>
.container {
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding: 20px;
  min-height: 80vh;
  box-sizing: border-box;
}

.notice-card {
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
}

.card-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 20px;
  text-align: center;
}

.el-table {
  width: 100%;
  margin-top: 20px;
}

.el-table .cell {
  text-align: center;
}

.el-button {
  width: 100%;
  font-size: 14px;
}

.dialog-title {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 20px;
}

.dialog-title-bold {
  font-size: 20px;
  font-weight: bold;
}

.el-dialog {
  border-radius: 8px;
  height: 2000px;


}

@media (max-width: 768px) {
  .notice-card {
    padding: 15px;
  }

  .card-title {
    font-size: 20px;
  }

  .el-table {
    font-size: 12px;
  }

  .el-table-column {
    padding: 5px 10px;
  }
}
</style>
