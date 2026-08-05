<#assign listDicts = []>
<#list columns as column>
  <#if column.list && column.dictType?has_content && !listDicts?seq_contains(column.dictType)>
    <#assign listDicts += [column.dictType]>
  </#if>
</#list>
<script setup lang="tsx">
import { ref } from 'vue';
import { NDivider } from 'naive-ui';
import { jsonClone } from '@sa/utils';
import { fetchBatchDelete${BusinessName}, fetchGet${BusinessName}List } from '@/service/api/${moduleNameKebab}/${businessNameKebab}';
import { useAppStore } from '@/store/modules/app';
import { useAuth } from '@/hooks/business/auth';
import { treeTransform, useNaiveTreeTable, useTableOperate } from '@/hooks/common/table';
import { useDownload } from '@/hooks/business/download';
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
<#list columns as column>
<#if column.query && column.queryType != "BETWEEN">
  ${column.javaField}: null,
</#if>
</#list>
  params: {}
});

const {
  columns,
  columnChecks,
  data,
  rows,
  getData,
  loading,
  expandedRowKeys,
  isCollapse,
  expandAll,
  collapseAll,
  scrollX
} = useNaiveTreeTable({
  keyField: '${pkColumn.javaField}',
  api: () => fetchGet${BusinessName}List(searchParams.value),
  transform: response =>
    treeTransform(response, { idField: '${treeCode}', parentIdField: '${treeParentCode}' }),
  columns: () => [
    {
      type: 'selection',
      align: 'center',
      width: 48
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
      width: 150,
      render: row => {
        const addBtn = () => (
          <ButtonIcon
            text
            type="primary"
            icon="material-symbols:add-2-rounded"
            tooltipContent={$t('common.add')}
            onClick={() => addInRow(row)}
          />
        );

        const editBtn = () => (
          <ButtonIcon
            text
            type="primary"
            icon="material-symbols:drive-file-rename-outline-outline"
            tooltipContent={$t('common.edit')}
            onClick={() => edit(row.${pkColumn.javaField})}
          />
        );

        const deleteBtn = () => (
          <ButtonIcon
            text
            type="error"
            icon="material-symbols:delete-outline"
            tooltipContent={$t('common.delete')}
            popconfirmContent={$t('common.confirmDelete')}
            onPositiveClick={() => handleDelete(row.${pkColumn.javaField})}
          />
        );

        const buttons = [];
        if (hasAuth('${moduleName}:${businessName}:add')) buttons.push(addBtn());
        if (hasAuth('${moduleName}:${businessName}:edit')) buttons.push(editBtn());
        if (hasAuth('${moduleName}:${businessName}:remove')) buttons.push(deleteBtn());

        return (
          <div class="flex-center gap-8px">
            {buttons.map((btn, index) => (
              <>
                {index !== 0 && <NDivider vertical />}
                {btn}
              </>
            ))}
          </div>
        );
      }
    }
  ]
});

const { drawerVisible, operateType, editingData, handleAdd, handleEdit, checkedRowKeys, onBatchDeleted, onDeleted } =
  useTableOperate(rows, '${pkColumn.javaField}', getData);

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

function addInRow(row: Api.${ModuleName}.${BusinessName}) {
  editingData.value = jsonClone(row);
  handleAdd();
}

function handleExport() {
  download('/${moduleName}/${businessName}/export', searchParams.value, `${functionName}_${r'${new Date().getTime()}'}.xlsx`);
}
</script>

<template>
  <div class="min-h-500px flex-col-stretch gap-16px overflow-hidden lt-sm:overflow-auto">
    <${BusinessName}Search v-model:model="searchParams" @search="getData" />
    <NCard title="${functionName}列表" :bordered="false" size="small" class="card-wrapper sm:flex-1-hidden">
      <template #header-extra>
        <TableHeaderOperation
          v-model:columns="columnChecks"
          :disabled-delete="checkedRowKeys.length === 0"
          :loading="loading"
          :show-add="hasAuth('${moduleName}:${businessName}:add')"
          :show-delete="hasAuth('${moduleName}:${businessName}:remove')"
          :show-export="false"
          @add="handleAdd"
          @delete="handleBatchDelete"
          @export="handleExport"
          @refresh="getData"
        >
          <template #prefix>
            <NButton v-if="!isCollapse" :disabled="!data.length" size="small" @click="expandAll">
              <template #icon>
                <icon-quill-expand />
              </template>
              全部展开
            </NButton>
            <NButton v-if="isCollapse" :disabled="!data.length" size="small" @click="collapseAll">
              <template #icon>
                <icon-quill-collapse />
              </template>
              全部收起
            </NButton>
          </template>
        </TableHeaderOperation>
      </template>
      <DataTable
        v-model:checked-row-keys="checkedRowKeys"
        v-model:expanded-row-keys="expandedRowKeys"
        :columns="columns"
        :data="data"
        :flex-height="!appStore.isMobile"
        :scroll-x="scrollX"
        :loading="loading"
        remote
        :row-key="row => row.${pkColumn.javaField}"
        class="sm:h-full"
      />
      <${BusinessName}OperateDrawer
        v-model:visible="drawerVisible"
        :operate-type="operateType"
        :row-data="editingData"
        @submitted="getData"
      />
    </NCard>
  </div>
</template>

<style scoped></style>
