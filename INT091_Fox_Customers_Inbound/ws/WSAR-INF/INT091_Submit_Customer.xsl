<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ws="urn:com.workday/workersync" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xtt="urn:com.workday/xtt" 
    xmlns:etv="urn:com.workday/etv" 
    xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:wd="urn:com.workday/bsvc"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="root">
    	<root>
        	<xsl:apply-templates select="data/customer_records/data"/>
        </root>
    </xsl:template>
    
    <xsl:template match="data/customer_records/data">
        <env:Envelope
            xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Submit_Customer_Request xmlns:wd="urn:com.workday/bsvc" wd:version="v36.1">
                    <!-- Update Logic Here? -->
                    <wd:Add_Only>true</wd:Add_Only>
                    <!--
                    <wd:Customer_Reference>
                        <wd:ID wd:type="Customer_ID"><xsl:value-of select="customer_id"/></wd:ID>
                    </wd:Customer_Reference>
                    -->
                    <wd:Business_Process_Parameters>
                        <wd:Auto_Complete>false</wd:Auto_Complete>
                        <wd:Comment_Data>
                            <wd:Comment><xsl:value-of select="request_correlation_id"/></wd:Comment>
                        </wd:Comment_Data>
                    </wd:Business_Process_Parameters>
                    <wd:Customer_Data>
                        <wd:Customer_ID><xsl:value-of select="customer_id"/></wd:Customer_ID>
                        <wd:Customer_Reference_ID><xsl:value-of select="customer_reference_id"/></wd:Customer_Reference_ID>
                        <wd:Customer_Name><xsl:value-of select="customer_name"/></wd:Customer_Name>
                        <wd:Submit>true</wd:Submit>
                        <wd:Customer_Category_Reference>
                            <wd:ID wd:type="Customer_Category_ID"><!--MAPPING?--><xsl:value-of select="customer_category"/></wd:ID>
                        </wd:Customer_Category_Reference>
                        <!--
                        <wd:Restricted_To_Companies_Reference>
                            <wd:ID wd:type="Company_Reference_ID">abcdef</wd:ID>
                        </wd:Restricted_To_Companies_Reference>
                        -->
                        <wd:Customer_Group_Reference>
                            <wd:ID wd:type="Customer_Group_ID"><!--MAPPING?--><xsl:value-of select="customer_group"/></wd:ID>
                        </wd:Customer_Group_Reference>
                        <!--
                        <wd:Payment_Terms_Reference>
                            <wd:ID wd:type="Payment_Terms_ID">abcdef</wd:ID>
                        </wd:Payment_Terms_Reference>
                        -->
                        <wd:Default_Payment_Type_Reference>
                            <wd:ID wd:type="Payment_Type_ID">Check</wd:ID>
                        </wd:Default_Payment_Type_Reference>
                        <!--
                        <wd:Interest_Rule_Reference>
                            <wd:ID wd:type="Interest_and_Late_Fee_Rule_ID">abcdef</wd:ID>
                        </wd:Interest_Rule_Reference>
                        <wd:Late_Fee_Rule_Reference>
                            <wd:ID wd:type="Interest_and_Late_Fee_Rule_ID">abcdef</wd:ID>
                        </wd:Late_Fee_Rule_Reference>
                        <wd:Exempt>true</wd:Exempt>
                        
                        <wd:Credit_Limit_Currency_Reference>
                            <wd:ID wd:type="Currency_ID">abcdef</wd:ID>
                        </wd:Credit_Limit_Currency_Reference>
                        -->
                        
                        <!-- WHAT VALUE IS THIS?-->
                        <!--<wd:Credit_Limit>12678967.54</wd:Credit_Limit>-->
                        <!--
                        <wd:Hierarchy_Credit_Limit>12678967.54</wd:Hierarchy_Credit_Limit>
                        <wd:Credit_Verification_Date>2021-10-19</wd:Credit_Verification_Date>
                        -->
                        <wd:Commercial_Credit_Score><xsl:value-of select="format-number(credit/credit_score * 100,'#')"/></wd:Commercial_Credit_Score>
                        <wd:Composite_Risk_Score>
                            <xsl:choose>
                                <xsl:when test="credit/credit_rating = 'A'">1</xsl:when>
                                <xsl:when test="credit/credit_rating = 'B'">2</xsl:when>
                                <xsl:when test="credit/credit_rating = 'C'">3</xsl:when>
                                <xsl:when test="credit/credit_rating = 'D'">4</xsl:when>
                            </xsl:choose>
                        </wd:Composite_Risk_Score>
                        <wd:Composite_Risk_Date><xsl:value-of select="concat(substring(credit/credit_report_date,7,4),'-',substring(credit/credit_report_date,1,2),'-',substring(credit/credit_report_date,4,2))"/></wd:Composite_Risk_Date>
                        <wd:Composite_Risk_Note><xsl:value-of select="credit/credit_report_comments"/></wd:Composite_Risk_Note>
                        <wd:DUNS_Number><xsl:value-of select="translate(credit/duns_number,'-','')"/></wd:DUNS_Number>
                        <!--
                        <wd:Tax_Code_Reference>
                            <wd:ID wd:type="Tax_Code_ID">abcdef</wd:ID>
                        </wd:Tax_Code_Reference>
                        -->
                        <!--
                        <wd:Customer_Security_Segment_Reference>
                            <wd:ID wd:type="Customer_Security_Segment_ID">abcdef</wd:ID>
                        </wd:Customer_Security_Segment_Reference>
                        -->
                        <wd:Business_Entity_Data>
                            
                            <wd:Business_Entity_Name><xsl:value-of select="customer_name"/></wd:Business_Entity_Name>
                            <!-- Needed??
                            <wd:Business_Entity_Phonetic_Name>abcdef</wd:Business_Entity_Phonetic_Name>
                            <wd:External_Entity_ID>abcdef</wd:External_Entity_ID
                            -->
                            <wd:Contact_Data>
                                <wd:Address_Data wd:Effective_Date="2021-10-19">
                                    <wd:Country_Reference>
                                        <wd:ID wd:type="ISO_3166-1_Alpha-3_Code"><xsl:value-of select="address/country"/></wd:ID>
                                    </wd:Country_Reference>
                                    <wd:Address_Line_Data wd:Type="ADDRESS_LINE_1"><xsl:value-of select="address/address_1"/></wd:Address_Line_Data>
                                    <wd:Municipality><xsl:value-of select="address/city"/></wd:Municipality>
                                    <wd:Country_Region_Reference>
                                        <wd:ID wd:type="Country_Region_ID"><xsl:value-of select="address/region"/></wd:ID>
                                    </wd:Country_Region_Reference>
                                    <wd:Postal_Code><xsl:value-of select="address/zip_code"/></wd:Postal_Code>
                                    <wd:Usage_Data wd:Public="true">
                                        <wd:Type_Data wd:Primary="true">
                                            <wd:Type_Reference>
                                                <wd:ID wd:type="Communication_Usage_Type_ID"><xsl:value-of select="address/address_usage_type"/></wd:ID>
                                            </wd:Type_Reference>
                                        </wd:Type_Data>
                                        <xsl:variable name="useforreference" select="tokenize(address/address_use_for,',')"/>
                                        <xsl:for-each select="$useforreference">
                                            <xsl:variable name="count" select="position()"/>
                                            <wd:Use_For_Reference>
                                                <wd:ID wd:type="Communication_Usage_Behavior_ID"><xsl:value-of select="$useforreference[$count]"/></wd:ID>
                                            </wd:Use_For_Reference>
                                        </xsl:for-each>
                                    </wd:Usage_Data>
                                    <!-- NEEDED??
                                    <wd:Address_Reference>
                                        <wd:ID wd:type="Address_ID">abcdef</wd:ID>
                                    </wd:Address_Reference>
                                    <wd:Address_ID>abcdef</wd:Address_ID>
                                    -->
                                </wd:Address_Data>
                                <!--
                                <wd:Phone_Data
                                    wd:Area_Code="{substring(phone/phone_number,2,3)}"
                                    wd:Do_Not_Replace_All="true">
                                    <wd:Country_ISO_Code>USA</wd:Country_ISO_Code>
                                    <wd:Phone_Number><xsl:value-of select="concat(substring(phone/phone_number,7,3),substring(phone/phone_number,11,3))"/></wd:Phone_Number>
                                    <wd:Phone_Device_Type_Reference>
                                        <wd:ID wd:type="Phone_Device_Type_ID"><xsl:value-of select="phone/phone_device_type"/></wd:ID>
                                    </wd:Phone_Device_Type_Reference>
                                    <wd:Usage_Data wd:Public="true">
                                        <wd:Type_Data wd:Primary="true">
                                            <wd:Type_Reference>
                                                <wd:ID wd:type="Communication_Usage_Type_ID"><xsl:value-of select="phone/phone_usage_type"/></wd:ID>
                                            </wd:Type_Reference>
                                        </wd:Type_Data>
                                        <xsl:variable name="useforreference" select="tokenize(phone/phone_use_for,',')"/>
                                        <xsl:for-each select="$useforreference">
                                            <xsl:variable name="count" select="position()"/>
                                            <wd:Use_For_Reference>
                                                <wd:ID wd:type="Communication_Usage_Behavior_ID"><xsl:value-of select="$useforreference[$count]"/></wd:ID>
                                            </wd:Use_For_Reference>
                                        </xsl:for-each>
                                    </wd:Usage_Data>
                                    NEEDED??
                                    <wd:Phone_Reference>
                                        <wd:ID wd:type="Phone_ID">abcdef</wd:ID>
                                    </wd:Phone_Reference>
                                    <wd:ID>abcdef</wd:ID>
                                </wd:Phone_Data>-->
                                <wd:Email_Address_Data wd:Do_Not_Replace_All="true">
                                    <wd:Email_Address><xsl:value-of select="email/email_id"/></wd:Email_Address>
                                    <wd:Usage_Data wd:Public="true">
                                        <wd:Type_Data wd:Primary="true">
                                            <wd:Type_Reference>
                                                <wd:ID wd:type="Communication_Usage_Type_ID"><xsl:value-of select="email/email_usage_type"/></wd:ID>
                                            </wd:Type_Reference>
                                        </wd:Type_Data>
                                        <xsl:variable name="useforreference" select="tokenize(email/email_use_for,',')"/>
                                        <xsl:for-each select="$useforreference">
                                            <xsl:variable name="count" select="position()"/>
                                            <wd:Use_For_Reference>
                                                <wd:ID wd:type="Communication_Usage_Behavior_ID"><xsl:value-of select="$useforreference[$count]"/></wd:ID>
                                            </wd:Use_For_Reference>
                                        </xsl:for-each>
                                    </wd:Usage_Data>
                                    <!-- NEEDED??
                                    <wd:Email_Reference>
                                        <wd:ID wd:type="Email_ID">abcdef</wd:ID>
                                    </wd:Email_Reference>
                                    <wd:ID>abcdef</wd:ID>
                                    -->
                                </wd:Email_Address_Data>
                            </wd:Contact_Data>
                        </wd:Business_Entity_Data>
                    </wd:Customer_Data>
                </wd:Submit_Customer_Request>
            </env:Body>
        </env:Envelope>
    </xsl:template>
</xsl:stylesheet>
