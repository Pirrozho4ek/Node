/* eslint-disable */
/* tslint:disable */
/*
 * ---------------------------------------------------------------
 * ## THIS FILE WAS GENERATED VIA SWAGGER-TYPESCRIPT-API        ##
 * ##                                                           ##
 * ## AUTHOR: acacode                                           ##
 * ## SOURCE: https://github.com/acacode/swagger-typescript-api ##
 * ---------------------------------------------------------------
 */

export interface DistributorsauthAdmin {
  address?: string;
  edit_option?: boolean;
}

export interface DistributorsauthDistributorInfo {
  Address?: string;

  /** @format uint64 */
  end_date?: string;
}

/**
 * MsgSendResponse defines the Msg/Send response type.
 */
export type DistributorsauthMsgAddAdminResponse = object;

/**
 * MsgSendResponse defines the Msg/Send response type.
 */
export type DistributorsauthMsgAddDistributorResponse = object;

/**
 * MsgSendResponse defines the Msg/Send response type.
 */
export type DistributorsauthMsgRemoveAdminResponse = object;

/**
 * MsgSendResponse defines the Msg/Send response type.
 */
export type DistributorsauthMsgRemoveDistributorResponse = object;

export interface DistributorsauthQueryAdminResponse {
  /** admin defines the admin info. */
  admin?: DistributorsauthAdmin;
}

export interface DistributorsauthQueryAdminsResponse {
  /** admins contains all the queried admins. */
  admins?: DistributorsauthAdmin[];
}

export interface DistributorsauthQueryDistributorResponse {
  /** distributor defines the distributor info. */
  distributor?: DistributorsauthDistributorInfo;
}

export interface DistributorsauthQueryDistributorsResponse {
  /** distributors contains all the queried distributors. */
  distributors?: DistributorsauthDistributorInfo[];
}

export interface ProtobufAny {
  "@type"?: string;
}

export interface RpcStatus {
  /** @format int32 */
  code?: number;
  message?: string;
  details?: ProtobufAny[];
}

import axios, { AxiosInstance, AxiosRequestConfig, AxiosResponse, ResponseType } from "axios";

export type QueryParamsType = Record<string | number, any>;

export interface FullRequestParams extends Omit<AxiosRequestConfig, "data" | "params" | "url" | "responseType"> {
  /** set parameter to `true` for call `securityWorker` for this request */
  secure?: boolean;
  /** request path */
  path: string;
  /** content type of request body */
  type?: ContentType;
  /** query params */
  query?: QueryParamsType;
  /** format of response (i.e. response.json() -> format: "json") */
  format?: ResponseType;
  /** request body */
  body?: unknown;
}

export type RequestParams = Omit<FullRequestParams, "body" | "method" | "query" | "path">;

export interface ApiConfig<SecurityDataType = unknown> extends Omit<AxiosRequestConfig, "data" | "cancelToken"> {
  securityWorker?: (
    securityData: SecurityDataType | null,
  ) => Promise<AxiosRequestConfig | void> | AxiosRequestConfig | void;
  secure?: boolean;
  format?: ResponseType;
}

export enum ContentType {
  Json = "application/json",
  FormData = "multipart/form-data",
  UrlEncoded = "application/x-www-form-urlencoded",
}

export class HttpClient<SecurityDataType = unknown> {
  public instance: AxiosInstance;
  private securityData: SecurityDataType | null = null;
  private securityWorker?: ApiConfig<SecurityDataType>["securityWorker"];
  private secure?: boolean;
  private format?: ResponseType;

  constructor({ securityWorker, secure, format, ...axiosConfig }: ApiConfig<SecurityDataType> = {}) {
    this.instance = axios.create({ ...axiosConfig, baseURL: axiosConfig.baseURL || "" });
    this.secure = secure;
    this.format = format;
    this.securityWorker = securityWorker;
  }

  public setSecurityData = (data: SecurityDataType | null) => {
    this.securityData = data;
  };

  private mergeRequestParams(params1: AxiosRequestConfig, params2?: AxiosRequestConfig): AxiosRequestConfig {
    return {
      ...this.instance.defaults,
      ...params1,
      ...(params2 || {}),
      headers: {
        ...(this.instance.defaults.headers || {}),
        ...(params1.headers || {}),
        ...((params2 && params2.headers) || {}),
      },
    };
  }

  private createFormData(input: Record<string, unknown>): FormData {
    return Object.keys(input || {}).reduce((formData, key) => {
      const property = input[key];
      formData.append(
        key,
        property instanceof Blob
          ? property
          : typeof property === "object" && property !== null
          ? JSON.stringify(property)
          : `${property}`,
      );
      return formData;
    }, new FormData());
  }

  public request = async <T = any, _E = any>({
    secure,
    path,
    type,
    query,
    format,
    body,
    ...params
  }: FullRequestParams): Promise<AxiosResponse<T>> => {
    const secureParams =
      ((typeof secure === "boolean" ? secure : this.secure) &&
        this.securityWorker &&
        (await this.securityWorker(this.securityData))) ||
      {};
    const requestParams = this.mergeRequestParams(params, secureParams);
    const responseFormat = (format && this.format) || void 0;

    if (type === ContentType.FormData && body && body !== null && typeof body === "object") {
      requestParams.headers.common = { Accept: "*/*" };
      requestParams.headers.post = {};
      requestParams.headers.put = {};

      body = this.createFormData(body as Record<string, unknown>);
    }

    return this.instance.request({
      ...requestParams,
      headers: {
        ...(type && type !== ContentType.FormData ? { "Content-Type": type } : {}),
        ...(requestParams.headers || {}),
      },
      params: query,
      responseType: responseFormat,
      data: body,
      url: path,
    });
  };
}

/**
 * @title entangle/distributorsauth/distributorsauth.proto
 * @version version not set
 */
export class Api<SecurityDataType extends unknown> extends HttpClient<SecurityDataType> {
  /**
   * No description
   *
   * @tags Query
   * @name QueryAdmins
   * @summary Queries admin info for all admins
   * @request GET:/entangle-blockchain/admins
   */
  queryAdmins = (params: RequestParams = {}) =>
    this.request<DistributorsauthQueryAdminsResponse, RpcStatus>({
      path: `/entangle-blockchain/admins`,
      method: "GET",
      format: "json",
      ...params,
    });

  /**
   * No description
   *
   * @tags Query
   * @name QueryDistributors
   * @summary Queries  distributor info for all distributors
   * @request GET:/entangle-blockchain/distributors
   */
  queryDistributors = (params: RequestParams = {}) =>
    this.request<DistributorsauthQueryDistributorsResponse, RpcStatus>({
      path: `/entangle-blockchain/distributors`,
      method: "GET",
      format: "json",
      ...params,
    });

  /**
   * No description
   *
   * @tags Query
   * @name QueryAdmin
   * @summary Queries admin info for given admin address.
   * @request GET:/entangle-blockchain/{admin_addr}/admin
   */
  queryAdmin = (adminAddr: string, params: RequestParams = {}) =>
    this.request<DistributorsauthQueryAdminResponse, RpcStatus>({
      path: `/entangle-blockchain/${adminAddr}/admin`,
      method: "GET",
      format: "json",
      ...params,
    });

  /**
   * No description
   *
   * @tags Query
   * @name QueryDistributor
   * @summary Queries distributor info for given distributor address.
   * @request GET:/entangle-blockchain/{distributor_addr}/distributor
   */
  queryDistributor = (distributorAddr: string, params: RequestParams = {}) =>
    this.request<DistributorsauthQueryDistributorResponse, RpcStatus>({
      path: `/entangle-blockchain/${distributorAddr}/distributor`,
      method: "GET",
      format: "json",
      ...params,
    });

  /**
   * No description
   *
   * @tags Msg
   * @name MsgAddAdmin
   * @summary Adding Admin method
   * @request POST:/entangle/admin/add
   */
  msgAddAdmin = (
    query?: { sender?: string; admin_address?: string; edit_option?: boolean },
    params: RequestParams = {},
  ) =>
    this.request<DistributorsauthMsgAddAdminResponse, RpcStatus>({
      path: `/entangle/admin/add`,
      method: "POST",
      query: query,
      format: "json",
      ...params,
    });

  /**
   * No description
   *
   * @tags Msg
   * @name MsgRemoveAdmin
   * @summary Remove Admin method
   * @request POST:/entangle/admin/remove
   */
  msgRemoveAdmin = (query?: { sender?: string; admin_address?: string }, params: RequestParams = {}) =>
    this.request<DistributorsauthMsgRemoveAdminResponse, RpcStatus>({
      path: `/entangle/admin/remove`,
      method: "POST",
      query: query,
      format: "json",
      ...params,
    });

  /**
   * No description
   *
   * @tags Msg
   * @name MsgAddDistributor
   * @summary Adding Distributor method
   * @request POST:/entangle/distributor/add
   */
  msgAddDistributor = (
    query?: { sender?: string; distributor_address?: string; end_date?: string },
    params: RequestParams = {},
  ) =>
    this.request<DistributorsauthMsgAddDistributorResponse, RpcStatus>({
      path: `/entangle/distributor/add`,
      method: "POST",
      query: query,
      format: "json",
      ...params,
    });

  /**
   * No description
   *
   * @tags Msg
   * @name MsgRemoveDistributor
   * @summary Remove Distributor method
   * @request POST:/entangle/distributor/remove
   */
  msgRemoveDistributor = (query?: { sender?: string; distributor_address?: string }, params: RequestParams = {}) =>
    this.request<DistributorsauthMsgRemoveDistributorResponse, RpcStatus>({
      path: `/entangle/distributor/remove`,
      method: "POST",
      query: query,
      format: "json",
      ...params,
    });
}
