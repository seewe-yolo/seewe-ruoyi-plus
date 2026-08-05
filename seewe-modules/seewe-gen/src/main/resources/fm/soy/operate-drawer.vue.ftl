<#assign operateColumns = []>
<#assign requiredColumns = []>
<#assign addColumns = []>
<#assign editColumns = []>
<#list columns as column>
  <#if column.insert || column.edit>
    <#assign operateColumns += [column]>
  </#if>
  <#if column.required && (column.insert || column.edit)>
    <#assign requiredColumns += [column]>
  </#if>
  <#if column.insert>
    <#assign addColumns += [column]>
  </#if>
  <#if column.edit>
    <#assign editColumns += [column]>
  </#if>
</#list>
<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import { jsonClone } from '@sa/utils';
import {
  fetchCreate${BusinessName},
<#if table.tree>
  fetchGet${BusinessName}List,
</#if>
  fetchUpdate${BusinessName}
} from '@/service/api/${moduleNameKebab}/${businessNameKebab}';
import { useFormRules, useNaiveForm } from '@/hooks/common/form';
<#if table.tree>
import { handleTree } from '@/utils/common';
</#if>
import { $t } from '@/locales';

defineOptions({
  name: '${BusinessName}OperateDrawer'
});

interface Props {
  /** the type of operation */
  operateType: NaiveUI.TableOperateType;
  /** the edit row data */
  rowData?: Api.${ModuleName}.${BusinessName} | null;
}

const props = defineProps<Props>();

interface Emits {
  (e: 'submitted'): void;
}

const emit = defineEmits<Emits>();

const visible = defineModel<boolean>('visible', {
  default: false
});

<#if table.tree>
const treeList = ref<Api.${ModuleName}.${BusinessName}[]>([]);

</#if>
const { formRef, validate, restoreValidation } = useNaiveForm();
const { createRequiredRule } = useFormRules();

const title = computed(() => {
  const titles: Record<NaiveUI.TableOperateType, string> = {
    add: '新增${functionName}',
    edit: '编辑${functionName}'
  };
  return titles[props.operateType];
});

type Model = Api.${ModuleName}.${BusinessName}OperateParams;

const model = ref<Model>(createDefaultModel());

function createDefaultModel(): Model {
  return {
<#list operateColumns as column>
    ${column.javaField}: <#if column.javaType == "String">''<#else>null</#if><#sep>,</#sep>
</#list>
  };
}

type RuleKey = Extract<keyof Model, <#if requiredColumns?size == 0>never<#else><#list requiredColumns as column>'${column.javaField}'<#sep> | </#sep></#list></#if>>;

const rules: Record<RuleKey, App.Global.FormRule> = {
<#list requiredColumns as column>
  ${column.javaField}: createRequiredRule('${column.columnComment}不能为空')<#sep>,</#sep>
</#list>
};

function handleUpdateModelWhenEdit() {
  model.value = createDefaultModel();
<#if table.tree>
  model.value.${treeParentCode} = props.rowData?.${treeCode} ?? ${treeRootValueTsLiteral};
</#if>

  if (props.operateType === 'edit' && props.rowData) {
    Object.assign(model.value, jsonClone(props.rowData));
  }
}

function closeDrawer() {
  visible.value = false;
}

async function handleSubmit() {
  await validate();

  const { <#list operateColumns as column>${column.javaField}<#sep>, </#sep></#list> } = model.value;

  if (props.operateType === 'add') {
    const { error } = await fetchCreate${BusinessName}({ <#list addColumns as column>${column.javaField}<#sep>, </#sep></#list> });
    if (error) return;
    window.$message?.success($t('common.addSuccess'));
  }

  if (props.operateType === 'edit') {
    const { error } = await fetchUpdate${BusinessName}({ <#list editColumns as column>${column.javaField}<#sep>, </#sep></#list> });
    if (error) return;
    window.$message?.success($t('common.updateSuccess'));
  }

  closeDrawer();
  emit('submitted');
}

<#if table.tree>
async function getTreeList() {
  const { data, error } = await fetchGet${BusinessName}List();
  if (error) return;
  const { tree } = handleTree(data, { idField: '${treeCode}', parentIdField: '${treeParentCode}' });
  treeList.value = tree;
}

</#if>
watch(visible, () => {
  if (visible.value) {
    handleUpdateModelWhenEdit();
    restoreValidation();
<#if table.tree>
    getTreeList();
</#if>
  }
});

<#if table.tree>
const treeOptions = computed(() => {
  return [
    {
      ${treeCode}: ${treeRootValueTsLiteral},
      ${treeName}: '顶级节点',
      children: treeList.value
    }
  ];
});
</#if>
</script>

<template>
  <NDrawer v-model:show="visible" :title="title" display-directive="show" :width="800" class="max-w-90%">
    <NDrawerContent :title="title" :native-scrollbar="false" closable>
      <NForm ref="formRef" :model="model" :rules="rules">
<#list columns as column>
<#if (column.insert || column.edit) && !column.pk>
        <NFormItem label="${column.columnComment}" path="${column.javaField}">
<#if table.tree && column.javaField == treeParentCode>
          <NTreeSelect
            v-model:value="model.${treeParentCode}"
            filterable
            class="h-full"
            key-field="${treeCode}"
            label-field="${treeName}"
            :options="treeOptions"
            :default-expanded-keys="[${treeRootValueTsLiteral}]"
          />
<#elseif column.htmlType == "editor">
          <TinymceEditor v-model:value="model.${column.javaField}" />
<#elseif column.htmlType == "textarea">
          <NInput
            v-model:value="model.${column.javaField}"
            :rows="3"
            type="textarea"
            placeholder="请输入${column.columnComment}"
          />
<#elseif column.htmlType == "select" && column.dictType?has_content>
          <DictSelect
            v-model:value="model.${column.javaField}"
            placeholder="请选择${column.columnComment}"
            dict-code="${column.dictType}"
            clearable
<#if !column.list && !column.query>
            immediate
</#if>
          />
<#elseif column.htmlType == "select">
          <NSelect
            v-model:value="model.${column.javaField}"
            placeholder="请选择${column.columnComment}"
            :options="[]"
            clearable
          />
<#elseif column.htmlType == "radio" && column.dictType?has_content>
          <DictRadio
            v-model:value="model.${column.javaField}"
            dict-code="${column.dictType}"
<#if !column.list && !column.query>
            immediate
</#if>
          />
<#elseif column.htmlType == "radio">
          <NRadioGroup v-model:value="model.${column.javaField}">
            <NSpace>
              <NRadio value="0" label="请选择字典生成" />
            </NSpace>
          </NRadioGroup>
<#elseif column.htmlType == "checkbox" && column.dictType?has_content>
          <DictCheckbox
            v-model:value="model.${column.javaField}"
            dict-code="${column.dictType}"
<#if !column.list && !column.query>
            immediate
</#if>
          />
<#elseif column.htmlType == "checkbox">
          <NCheckboxGroup v-model:value="model.${column.javaField}">
            <NSpace>
              <NCheckbox value="0" label="请选择字典生成" />
            </NSpace>
          </NCheckboxGroup>
<#elseif column.htmlType == "switch">
          <NSwitch
            v-model:value="model.${column.javaField}"
<#if column.javaType == "Boolean">
            :checked-value="true"
            :unchecked-value="false"
<#elseif column.javaType == "Integer" || column.javaType == "Long">
            :checked-value="0"
            :unchecked-value="1"
<#else>
            checked-value="0"
            unchecked-value="1"
</#if>
          />
<#elseif column.htmlType == "datetime">
          <NDatePicker
            v-model:formatted-value="model.${column.javaField}"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
          />
<#elseif column.htmlType == "inputNumber">
          <NInputNumber v-model:value="model.${column.javaField}" placeholder="请输入${column.columnComment}" />
<#elseif column.htmlType == "imageUpload">
          <OssUpload v-model:value="model.${column.javaField}" upload-type="image" />
<#elseif column.htmlType == "fileUpload">
          <OssUpload v-model:value="model.${column.javaField}" upload-type="file" />
<#else>
          <NInput v-model:value="model.${column.javaField}" placeholder="请输入${column.columnComment}" />
</#if>
        </NFormItem>
</#if>
</#list>
      </NForm>
      <template #footer>
        <NSpace :size="16">
          <NButton @click="closeDrawer">{{ $t('common.cancel') }}</NButton>
          <NButton type="primary" @click="handleSubmit">{{ $t('common.confirm') }}</NButton>
        </NSpace>
      </template>
    </NDrawerContent>
  </NDrawer>
</template>

<style scoped></style>
