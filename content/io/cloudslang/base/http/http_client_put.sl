#   (c) Copyright 2014-2017 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: Executes a PUT REST call.
#!
#! @input url: URL to which the call is made.
#! @input auth_type: Optional - Type of authentication used to execute the request on the target server.
#!                   Valid: 'basic', 'form', 'springForm', 'digest', 'ntlm', 'kerberos', 'anonymous' (no authentication)
#!                   Default: 'basic'
#! @input username: Optional - Username used for URL authentication; for NTLM authentication.
#!                  Format: 'domain\user'
#! @input password: Optional - Password used for URL authentication.
#! @input proxy_host: Optional - Proxy server used to access the web site.
#! @input proxy_port: Optional - Proxy server port.
#!                    Default: '8080'
#! @input proxy_username: Optional - User name used when connecting to the proxy.
#! @input proxy_password: Optional - Proxy server password associated with the <proxy_username> input value.
#! @input trust_keystore: Optional - The pathname of the Java TrustStore file. This contains certificates from
#!                        other parties that you expect to communicate with, or from Certificate Authorities that
#!                        you trust to identify other parties.  If the protocol (specified by the 'url') is not
#!                       'https' or if trust_all_roots is 'true' this input is ignored.
#!                        Default value: ''
#!                        Format: Java KeyStore (JKS)
#! @input trust_password: Optional - The password associated with the trust_keystore file. If trust_all_roots is false
#!                        and trust_keystore is empty, trust_password default will be supplied.
#! @input keystore: Optional - the pathname of the Java KeyStore file.
#!                  You only need this if the server requires client authentication.
#!                  If the protocol (specified by the 'url') is not 'https' or if trust_all_roots is 'true'
#!                  this input is ignored.
#!                  Default value: ''
#!                  Format: Java KeyStore (JKS)
#! @input keystore_password: Optional - The password associated with the KeyStore file. If trust_all_roots is false and
#!                           keystore is empty, keystore_password default will be supplied.
#!                           Default value: ''
#! @input connect_timeout: Optional - Time in seconds to wait for a connection to be established.
#!                         Default: '0' (infinite)
#! @input socket_timeout: Optional - Time in seconds to wait for data to be retrieved.
#!                        Default: '0' (infinite)
#! @input request_character_set: Optional - Character encoding to be used for the HTTP request body; should not
#!                               be provided for method=GET, HEAD, TRACE.
#!                               Default: 'ISO-8859-1'
#! @input headers: Optional - List containing the headers to use for the request separated by new line (CRLF).
#!                 Header name - value pair will be separated by ":"
#!                 Format: According to HTTP standard for headers (RFC 2616)
#!                 Example: 'Accept:text/plain'
#! @input query_params: Optional - List containing query parameters to append to the URL.
#!                      Examples: 'parameterName1=parameterValue1&parameterName2=parameterValue2;'
#! @input body: Optional - String to include in body for HTTP PUT operation.
#! @input content_type: Optional - Content type that should be set in the request header, representing the
#!                      MIME-type of the data in the message body.
#!                      Default: 'text/plain'
#! @input method: HTTP method used.
#!                Default: 'PUT'
#!
#! @output return_result: The response of the operation in case of success or the error message otherwise.
#! @output error_message: Return_result if status_code is not contained in interval between '200' and '299'.
#! @output return_code: '0' if success, '-1' otherwise.
#! @output status_code: Status code of the HTTP call.
#! @output response_headers: Response headers string from the HTTP Client REST call.
#!
#! @result SUCCESS: PUT REST call executed successfully.
#! @result FAILURE: Something went wrong.
#!!#
########################################################################################################################

namespace: io.cloudslang.base.http

imports:
  http: io.cloudslang.base.http

flow:
  name: http_client_put

  inputs:
    - url
    - auth_type:
        required: false
    - username:
        required: false
    - password:
        required: false
        sensitive: true
    - proxy_host:
        required: false
    - proxy_port:
        default: '8080'
        required: false
    - proxy_username:
        required: false
    - proxy_password:
        required: false
        sensitive: true
    - trust_keystore:
        default: ${get_sp('io.cloudslang.base.http.trust_keystore')}
        required: false
    - trust_password:
        default: ${get_sp('io.cloudslang.base.http.trust_password')}
        required: false
        sensitive: true
    - keystore:
        default: ${get_sp('io.cloudslang.base.http.keystore')}
        required: false
    - keystore_password:
        default: ${get_sp('io.cloudslang.base.http.keystore_password')}
        required: false
        sensitive: true
    - connect_timeout:
        default: '0'
        required: false
    - socket_timeout:
        default: '0'
        required: false
    - headers:
        required: false
    - query_params:
        required: false
    - body:
        required: false
    - content_type:
        default: 'text/plain'
        required: false
    - request_character_set:
        required: false
    - method:
        default: 'PUT'
        private: true

  workflow:
    - http_client_action_put:
        do:
          http.http_client_action:
            - url
            - auth_type
            - username
            - password
            - proxy_host
            - proxy_port
            - proxy_username
            - proxy_password
            - trust_all_roots: 'false'
            - x_509_hostname_verifier: 'strict'
            - trust_keystore
            - trust_password
            - keystore
            - keystore_password
            - connect_timeout
            - socket_timeout
            - request_character_set
            - headers
            - query_params
            - body
            - content_type
            - method
        publish:
          - return_result
          - error_message
          - return_code
          - status_code
          - response_headers

  outputs:
    - return_result
    - error_message
    - return_code
    - status_code
    - response_headers
