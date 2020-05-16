<template>
    <div class="app-container">
        <div class="filter-container">
            <el-form :model="queryParams"  :inline="true">

                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="getList">搜索</el-button>
                    <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAdd">新增</el-button>
                </el-form-item>
            </el-form>
        </div>

        <el-table  v-loading="loading" :data="dataList"  fit  highlight-current-row style="width: 100%;">
            <#list columns as column>
                <#if column.lowerAttrName != "id" >
                    <#if column.lowerAttrName != "createBy" >
                        <#if column.lowerAttrName != "createDate" >
                            <#if column.lowerAttrName != "updateBy" >
                                <#if column.lowerAttrName != "updateDate" >
                                    <#if column.lowerAttrName != "remarks" >
                                        <#if column.lowerAttrName != "delFlag" >
                                            <#if 0 != column.columnName?index_of("is_")>
              <el-table-column prop="${column.lowerAttrName}" align="center" label="${column.comments}"  />
                                            <#else>
              <el-table-column prop="has${column.lowerAttrName?substring(2)}" align="center" label="${column.comments}"  />
                                            </#if>
                                        </#if>
                                    </#if>
                                </#if>
                            </#if>
                        </#if>
                    </#if>
                </#if>
            </#list>
            <el-table-column label="更新时间" align="center" prop="updateDate">
                <template slot-scope="scope">
                    <span>{{ scope.row.updateDate | dateFormat('YYYY-MM-DD HH:mm') }}</span>
                </template>
            </el-table-column>
            <el-table-column label="操作" align="center" >
                <template slot-scope="scope">
                    <el-button
                            size="mini"
                            type="text"
                            icon="el-icon-edit"
                            @click="handleUpdate(scope.row)"
                    >修改</el-button>
                    <el-button
                            size="mini"
                            type="text"
                            icon="el-icon-delete"
                            @click="handleDelete(scope.row)"
                    >删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <pagination  :total="total" :page.sync="queryParams.current"  :limit.sync="queryParams.size" @pagination="getList"  />

        <!-- 添加或修改对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <#list columns as column>
                    <#if column.lowerAttrName != "id" >
                        <#if column.lowerAttrName != "createBy" >
                            <#if column.lowerAttrName != "createDate" >
                                <#if column.lowerAttrName != "updateBy" >
                                    <#if column.lowerAttrName != "updateDate" >
                                        <#if column.lowerAttrName != "remarks" >
                                            <#if column.lowerAttrName != "delFlag" >
                                                <#if 0 != column.columnName?index_of("is_")>
                <el-form-item label="${column.comments}" prop="${column.lowerAttrName}">
                    <el-input v-model="form.${column.lowerAttrName}" placeholder="请输入${column.comments}" />
                </el-form-item>
                                                <#else>
                <el-form-item label="${column.comments}" prop="has${column.lowerAttrName?substring(2)}">
                    <el-input v-model="form.has${column.lowerAttrName?substring(2)}" placeholder="请输入${column.comments}" />
                </el-form-item>
                                                </#if>
                                            </#if>
                                        </#if>
                                    </#if>
                                </#if>
                            </#if>
                        </#if>
                    </#if>
                </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>

    </div>
</template>


<script>
    import Pagination from '@/components/Pagination'
    export default {
        name: '${className}',
        components: { Pagination },
        data() {
            return {
                // 弹出层标题
                title: '',
                // 遮罩层
                loading: true,
                // 总数量
                total: 0,
                // 列表数据
                dataList: [],
                // 是否显示弹出层
                open: false,
                // 查询参数
                queryParams: {
                    current: 1,
                    size: 10,
                },
                // 表单参数
                form: {

                },
                // 表单校验
                rules: {
                    // name: [
                    //     { required: true, message: '角色名称不能为空', trigger: 'blur' }
                    // ],
                }
            }
        },
        created() {
            this.getList()
        },
        methods: {
            /** 查询列表 */
            getList() {
                this.$store.dispatch('${moduleName}/${pathName}/findPage', this.queryParams)
                    .then((data) => {
                    this.dataList = data.records
                    this.total = data.total
                    this.loading = false
                })
            .catch((err) => {
                    console.log('失败' + err)
                })
            },
            // 取消按钮
            cancel() {
                this.open = false
                this.reset()
            },
            // 表单重置
            reset() {
                this.$nextTick(()=>{
                    this.$refs['form'].clearValidate();
                 })
                this.form = {
                }
            },
            /** 新增按钮操作 */
            handleAdd(row) {
                this.reset()
                this.open = true
                this.title = '添加'
            },
            /** 删除按钮操作 */
            handleDel(id) {
                this.$store.dispatch('${moduleName}/${pathName}/delById', id).then(() => {
                    this.getList()
                    this.msg('删除成功')
                })
            },
            /** 修改按钮操作 */
            handleUpdate(row) {
                this.reset()
                this.$store.dispatch('${moduleName}/${pathName}/getById', row.id)
                    .then((data) => {
                    this.form = data
                    this.open = true
                    this.title = '修改'
                }).catch((err) => {
                    console.log('失败' + err)
                })
            },
            /** 提交按钮 */
            submitForm: function() {
                this.$refs['form'].validate(valid => {
                    if (valid) {
                        if (this.form.id !== undefined) {
                            this.$store.dispatch('${moduleName}/${pathName}/updateById', this.form).then(data => {
                                this.msg('修改成功')
                                this.open = false
                                this.getList()
                            })
                        } else {
                            this.$store.dispatch('${moduleName}/${pathName}/saveData', this.form).then(res => {
                                this.msg('新增成功')
                                this.open = false
                                this.getList()
                            })
                        }
                    }
                })
            },
            /** 删除按钮操作 */
            handleDelete(row) {
                this.$confirm('是否确认删除名称为"' + row.id + '"的数据项?', '警告', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.handleDel(row.id)
                })
            }
        }
    }
</script>
