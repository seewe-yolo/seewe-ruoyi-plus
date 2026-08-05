<#assign listDicts = []>
<#list columns as column>
  <#if column.list && column.dictType?has_content && !listDicts?seq_contains(column.dictType)>
    <#assign listDicts += [column.dictType]>
  </#if>
</#list>
<script setup lang="tsx">
import { ref } from 'vue';
import { NDivider } from 'naive-ui';
import { fetchBatchDelete${BusinessName}, fetchGet${BusinessName}List } from '@/service/api/${moduleNameKebab}/${businessNameKebab}';
import { useAppStore } from '@/store/modules/app';
import { useAuth } from '@/hooks/business/auth';
import { useDownload } from '@/hooks/business/download';
import { defaultTransform, useNaivePaginatedTable, useTableOperate } from '@/hooks/common/table';
import { $t } from '@/locales';
import ButtonIcon from '@/components/custom/button-icon.vue';
import ${BusinessName}OperateDrawer from './modules/${businessNameKebab}-operate-drawer.vue';
import ${BusinessName}Search from './modules/${businessNameKebab}-search.vue';
<#if listDicts?size gt 0>
import { useDict } from '@/hooks/business/dict';
</#if>

defineOptions({
  name: '${BusinessName}List'
});

<#list listDicts as dictType>
useDict('${dictType}');
</#list>

const appStore = useAppStore();
const { download } = useDownload();
const { hasAuth } = useAuth();

const searchParams = ref<Api.${ModuleName}.${BusinessName}SearchParams>({
  pageNum: 1,
  pageSize: 10,
<#list columns as column>
<#if column.query && column.queryType != "BETWEEN">
  ${column.javaField}: null,
</#if>
</#list>
  params: {}
});

const { columns, columnChecks, data, getData, getDataByPage, loading, mobilePagination, scrollX } =
  useNaivePaginatedTable({
    api: () => fetchGet${BusinessName}List(searchParams.value),
    transform: response => defaultTransform(response),
    onPaginationParamsChange: params => {
      searchParams.value.pageNum = params.page;
      searchParams.value.pageSize = params.pageSize;
    },
    columns: () => [
      {
        type: 'selection',
        align: 'center',
        width: 48
      },
      {
        key: 'index',
        title: $t('common.index'),
        align: 'center',
        width: 64,
        render: (_, index) => index + 1
      },
<#list columns as column>
<#if column.list>
      {
        key: '${column.javaField}',
        title: '${column.columnComment}',
        align: 'center',
        minWidth: 120<#if column.dictType?has_content>,
        render(row) {
          return <DictTag value={row.${column.javaField}} dictCode="${column.dictType}" />;
        }</#if>
      },
</#if>
</#list>
      {
        key: 'operate',
        title: $t('common.operate'),
        align: 'center',
        width: 130,
        render: row => {
          const divider = () => {
            if (!hasAuth('${moduleName}:${businessName}:edit') || !hasAuth('${moduleName}:${businessName}:remove')) {
              return null;
            }
            return <NDivider vertical />;
          };

          const editBtn = () => {
            if (!hasAuth('${moduleName}:${businessName}:edit')) {
              return null;
            }
            return (
              <ButtonIcon
                text
                type="primary"
                icon="material-symbols:drive-file-rename-outline-outline"
                tooltipContent={$t('common.edit')}
                onClick={() => edit(row.${pkColumn.javaField})}
              />
            );
          };

          const deleteBtn = () => {
            if (!hasAuth('${moduleName}:${businessName}:remove')) {
              return null;
            }
            return (
              <ButtonIcon
                text
                type="error"
                icon="material-symbols:delete-outline"
                tooltipContent={$t('common.delete')}
                popconfirmContent={$t('common.confirmDelete')}
                onPositiveClick={() => handleDelete(row.${pkColumn.javaField})}
              />
            );
          };

          return (
            <div class="flex-center gap-8px">
              {editBtn()}
              {divider()}
              {deleteBtn()}
            </div>
          );
        }
      }
    ]
  });

const { drawerVisible, operateType, editingData, handleAdd, handleEdit, checkedRowKeys, onBatchDeleted, onDeleted } =
  useTableOperate(data, '${pkColumn.javaField}', getData);

async function handleBatchDelete() {
  const { error } = await fetchBatchDelete${BusinessName}(checkedRowKeys.value);
  if (error) return;
  onBatchDeleted();
}

async function handleDelete(${pkColumn.javaField}: CommonType.IdType) {
  const { error } = await fetchBatchDelete${BusinessName}([${pkColumn.javaField}]);
  if (error) return;
  onDeleted();
}

function edit(${pkColumn.javaField}: CommonType.IdType) {
  handleEdit(${pkColumn.javaField});
}

function handleExport() {
  download('/${moduleName}/${businessName}/export', searchParams.value, `${functionName}_${r'${new Date().getTime()}'}.xlsx`);
}
</script>

<template>
  <div class="min-h-500px flex-col-stretch gap-16px overflow-hidden lt-sm:overflow-auto">
    <${BusinessName}Search v-model:model="searchParams" @search="getDataByPage" />
    <NCard title="${functionName}列表" :bordered="false" size="small" class="card-wrapper sm:flex-1-hidden">
      <template #header-extra>
        <TableHeaderOperation
          v-model:columns="columnChecks"
          :disabled-delete="checkedRowKeys.length === 0"
          :loading="loading"
          :show-add="hasAuth('${moduleName}:${businessName}:add')"
          :show-delete="hasAuth('${moduleName}:${businessName}:remove')"
          :show-export="hasAuth('${moduleName}:${businessName}:export')"
          @add="handleAdd"
          @delete="handleBatchDelete"
          @export="handleExport"
          @refresh="getData"
        />
      </template>
      <DataTable
        v-model:checked-row-keys="checkedRowKeys"
        :columns="columns"
        :data="data"
        :flex-height="!appStore.isMobile"
        :scroll-x="scrollX"
        :loading="loading"
        remote
        :row-key="row => row.${pkColumn.javaField}"
        :pagination="mobilePagination"
        class="sm:h-full"
      />
      <${BusinessName}OperateDrawer
        v-model:visible="drawerVisible"
        :operate-type="operateType"
        :row-data="editingData"
        @submitted="getDataByPage"
      />
    </NCard>
  </div>
</template>

<style scoped></style>
