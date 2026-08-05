<#assign dateRangeColumns = []>
<#list columns as column>
  <#if column.query && column.htmlType == "datetime" && column.queryType == "BETWEEN">
    <#assign dateRangeColumns += [column]>
  </#if>
</#list>
<script setup lang="ts">
import { <#if dateRangeColumns?size gt 0>ref, </#if>toRaw } from 'vue';
import { jsonClone } from '@sa/utils';
import { useNaiveForm } from '@/hooks/common/form';
import { $t } from '@/locales';

defineOptions({
  name: '${BusinessName}Search'
});

interface Emits {
  (e: 'search'): void;
}

const emit = defineEmits<Emits>();

const { formRef, validate, restoreValidation } = useNaiveForm();

<#list dateRangeColumns as column>
const dateRange${column.capJavaField} = ref<[string, string] | null>(null);

</#list>
const model = defineModel<Api.${ModuleName}.${BusinessName}SearchParams>('model', { required: true });

const defaultModel = jsonClone(toRaw(model.value));

<#list dateRangeColumns as column>
function onDateRange${column.capJavaField}Update(value: [string, string] | null) {
  model.value.params = {
    ...model.value.params,
    begin${column.capJavaField}: value?.[0],
    end${column.capJavaField}: value?.[1]
  };
}

</#list>
function resetModel() {
<#list dateRangeColumns as column>
  dateRange${column.capJavaField}.value = null;
</#list>
  Object.assign(model.value, defaultModel);
}

async function reset() {
  await restoreValidation();
  resetModel();
  emit('search');
}

async function search() {
  await validate();
  emit('search');
}
</script>

<template>
  <NCard :bordered="false" size="small" class="card-wrapper">
    <NCollapse>
      <NCollapseItem :title="$t('common.search')" name="${moduleNameKebab}-${businessNameKebab}-search">
        <NForm ref="formRef" :model="model" label-placement="left" :label-width="80">
          <NGrid responsive="screen" item-responsive>
<#list columns as column>
<#if column.query>
            <NFormItemGi
              span="24 s:12 m:6"
              label="${column.columnComment}"
              label-width="auto"
              path="${column.javaField}"
              class="pr-24px"
            >
<#if column.dictType?has_content>
              <DictSelect
                v-model:value="model.${column.javaField}"
                placeholder="请选择${column.columnComment}"
                dict-code="${column.dictType}"
                clearable
<#if !column.list>
                immediate
</#if>
              />
<#elseif column.htmlType == "select" || column.htmlType == "radio" || column.htmlType == "checkbox">
              <NSelect
                v-model:value="model.${column.javaField}"
                placeholder="请选择${column.columnComment}"
                :options="[]"
                clearable
              />
<#elseif column.htmlType == "switch">
              <NSelect
                v-model:value="model.${column.javaField}"
                placeholder="请选择${column.columnComment}"
                :options="[<#if column.javaType == 'Boolean'>{ label: '是', value: true }, { label: '否', value: false }<#elseif column.javaType == 'Integer' || column.javaType == 'Long'>{ label: '开启', value: 0 }, { label: '关闭', value: 1 }<#else>{ label: '开启', value: '0' }, { label: '关闭', value: '1' }</#if>]"
                clearable
              />
<#elseif column.htmlType == "datetime" && column.queryType == "BETWEEN">
              <NDatePicker
                v-model:formatted-value="dateRange${column.capJavaField}"
                type="datetimerange"
                value-format="yyyy-MM-dd HH:mm:ss"
                clearable
                :default-time="['00:00:00', '23:59:59']"
                @update:formatted-value="onDateRange${column.capJavaField}Update"
              />
<#elseif column.htmlType == "datetime">
              <NDatePicker
                v-model:formatted-value="model.${column.javaField}"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                clearable
              />
<#elseif column.htmlType == "inputNumber">
              <NInputNumber v-model:value="model.${column.javaField}" placeholder="请输入${column.columnComment}" clearable />
<#else>
              <NInput v-model:value="model.${column.javaField}" placeholder="请输入${column.columnComment}" />
</#if>
            </NFormItemGi>
</#if>
</#list>
            <NFormItemGi :show-feedback="false" span="24" class="pr-24px">
              <NSpace class="w-full" justify="end">
                <NButton @click="reset">
                  <template #icon>
                    <icon-ic-round-refresh class="text-icon" />
                  </template>
                  {{ $t('common.reset') }}
                </NButton>
                <NButton type="primary" ghost @click="search">
                  <template #icon>
                    <icon-ic-round-search class="text-icon" />
                  </template>
                  {{ $t('common.search') }}
                </NButton>
              </NSpace>
            </NFormItemGi>
          </NGrid>
        </NForm>
      </NCollapseItem>
    </NCollapse>
  </NCard>
</template>

<style scoped></style>
