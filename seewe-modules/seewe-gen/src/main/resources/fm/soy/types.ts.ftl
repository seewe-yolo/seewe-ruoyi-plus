<#assign baseEntity = ["createDept", "createBy", "createTime", "updateBy", "updateTime"]>
<#assign queryColumns = []>
<#assign operateColumns = []>
<#list columns as column>
  <#if column.query && column.queryType != "BETWEEN">
    <#assign queryColumns += [column]>
  </#if>
  <#if column.insert || column.edit>
    <#assign operateColumns += [column]>
  </#if>
</#list>
/**
 * Namespace Api
 *
 * All backend api type
 */
declare namespace Api {
  /**
   * namespace ${ModuleName}
   *
   * backend api module: "${ModuleName}"
   */
  namespace ${ModuleName} {
    /** ${businessNameWords} */
    type ${BusinessName} = Common.CommonRecord<{
<#list columns as column>
<#if !baseEntity?seq_contains(column.javaField)>
      /** ${column.columnComment} */
      ${column.javaField}: <#if column.javaField?lower_case?contains("id")>CommonType.IdType<#elseif column.javaType == "Long" || column.javaType == "Integer" || column.javaType == "Double" || column.javaType == "Float" || column.javaType == "BigDecimal">number<#elseif column.javaType == "Boolean">boolean<#else>string</#if>;
</#if>
</#list>
    }>;

    /** ${businessNameWords} search params */
    type ${BusinessName}SearchParams = CommonType.RecordNullable<
      Pick<Api.${ModuleName}.${BusinessName}, <#if queryColumns?size == 0>never<#else><#list queryColumns as column>'${column.javaField}'<#sep> | </#sep></#list></#if>> & Api.Common.CommonSearchParams
    >;

    /** ${businessNameWords} operate params */
    type ${BusinessName}OperateParams = CommonType.RecordNullable<
      Pick<Api.${ModuleName}.${BusinessName}, <#if operateColumns?size == 0>never<#else><#list operateColumns as column>'${column.javaField}'<#sep> | </#sep></#list></#if>>
    >;

    /** ${businessNameWords} list */
    type ${BusinessName}List = <#if table.tree>${BusinessName}[]<#else>Api.Common.PaginatingQueryRecord<${BusinessName}></#if>;
  }
}
