<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <script src="<%=path%>/js/jquery.cityselect.js"></script>
    <script src="<%=path%>/js/fileinput.js"></script>
    <script src="<%=path%>/js/fileinput.min.js"></script>
    <title>Seller Center</title>
    <style>

        @media ( min-width :768px) {
            #cartinfo{
                margin-top: 51px;
                margin-left:5%;
                margin-right:10%;
            }
        }
        @media ( min-width :1440px) {
            #cartinfo{
                margin-top: 21px;
                margin-left:10%;
                margin-right:10%;
            }

        }
    </style>
    <script>
        $(document).ready(function(){

            $(".tab1 .single-bottom").hide();

            $("#lend-book-list").hide();
            $("#lend-book-history-list").hide();
            $("#sell-book-list").hide();


            $(".tab1 ul").click(function(){
                $(".tab1 .single-bottom").slideToggle(300);
            });





            $("#show-lend-book-list").click(function(){
                $("#lend-book-list").hide();
                $("#lend-book-history-list").hide();
                $("#sell-book-list").hide();
                $("#lend-book-list").show();

            });

            $("#show-lend-book-history-list").click(function(){
                $("#lend-book-list").hide();
                $("#lend-book-history-list").hide();
                $("#sell-book-list").hide();
                $("#lend-book-history-list").show();

            });
            $("#show-sell-book-list").click(function(){
                $("#lend-book-list").hide();
                $("#lend-book-history-list").hide();
                $("#sell-book-list").hide();
                $("#sell-book-list").show();

            });

        });

        function creditRating(borrowID){
            var creditRatingFormID = "creditRatingForm" + borrowID;
            $("#"+creditRatingFormID).show();
        }

        function submitRating(borrowID){
            var creditRatingFormID = "creditRatingForm" + borrowID;
            var creditRatingBtnID = "creditRatingBtn" + borrowID;
            var params = $("#"+creditRatingFormID).serialize();
            $.ajax({
                url:'<%=path%>/commentAction/honestyRatingWhenBorrow',
                type:'POST',
                data:params,
                success:function(msg){
                    if(msg.success){
                        showTip('信用评价成功！','success');
                        $("#"+creditRatingBtnID).remove();
                        $("#"+creditRatingFormID).remove();
                    }
                },
                error:function(xhr,status,error){
                    alert('status='+status+',error='+error);
                }
            });
        }

        function deliverBorrowBook(borrowID){
            var borrowDeliveryID = "borrowDelivery"+borrowID;
            var fhDateID = "fhDate"+borrowID;
            var deliverBorrowBtn = "deliverBorrowBtn"+borrowID;
            var statusID = "borrowStatus"+borrowID;
            var params = $("#"+borrowDeliveryID);
            $.ajax({
                url:'<%=path%>/borrowAction/deliverBorrowOrder',
                type:'POST',
                data:params,
                success:function(msg){
                    if(msg.success){
                        var fhDate = msg.fhDate;
                        showTip('发货成功！','success');
                        $("#"+statusID).html("当前状态：卖家已发货");
                        $("#"+fhDateID).html("发货日期："+fhDate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                        $("#"+fhDateID).show();
                        $("#"+borrowDeliveryID).remove();
                        $("#"+deliverBorrowBtn).remove();
                    }else{
                        showTip('发货失败！','danger');
                    }
                },
                error:function(xhr,status,error){
                    alert('status='+status+',error='+error);
                }
            });
        }

    </script>
    <style>
        @media ( min-width :768px) {

            .form-control-noNewline {
                width: 100px;
                display: inline;
            }

            .form-horizontal .form-group-auto {
                margin-right: 0px;
                margin-left: 0px;
            }
        }
    </style>

</head>
<body>
<!-- header -->
<s:action name="header" executeResult="true" namespace="/"/><!-- home page -->
<div class="products">
    <div class="container">
        <div class="col-md-3 rsiderbar span_1_of_left">
            <section class="sky-form">
                <div class="product_right">
                    <h3 class="m_2"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span>操作选单</h3>

                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="#">个人信息</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="#">卖家中心</a></li>
                            <li class="by"><span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span></li>
                        </ul>
                        <div class="clearfix"> </div>
                        <div class="single-bottom">
                            <a id="show-lend-book-list" href="#"><p>尚未归还的图书</p></a>
                            <a id="show-lend-book-history-list" href="#"><p>已归还的图书</p></a>
                            <a id="show-sell-book-list" href="#"><p>已卖出的图书</p></a>
                        </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="#">我的发布</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="#">我的借阅</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="#">我的交换</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="#">我的订单</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </section>
        </div>
        <h3 align="center">卖家中心</h3>
        <div id="tip"></div>
        <div id="cartinfo" class="cart-item">
            <div class="container">
                <div id="lend-book-list">
                    <h4>尚未归还的图书</h4>
                    <!-- 以下迭代显示尚未归还的图书 -->
                    <s:iterator value="#lendBookList" status="map_state">
                        <div id="borrowBook<s:property value="borrowID"/>" class="cart-header">
                            <div class="cart-sec simpleCart_shelfItem">
                                <div class="cart-item cyc">
                                    <img src="<%=path%>/imageAction/showImage?imageID=<s:property value="imageID"/>" class="img-responsive" alt="">
                                </div>
                                <div class="cart-item-info">
                                    <h4>
                                        <a href="<%=path%>/bookAction/showBookProfile?bookID=<s:property value="bookID"/>">
                                            书名：<s:property value="bookName"/></a><br>
                                        <s:if test="borrowStatus=='BUYER_NOTPAID'">
                                            <span id="borrowStatus<s:property value="borrowID"/>">当前状态：买家未付款</span>
                                        </s:if>
                                        <s:elseif test="borrowStatus=='SELLER_NOT_SHIPPED'">
                                            <span id="borrowStatus<s:property value="borrowID"/>">当前状态：卖家未发货</span>
                                        </s:elseif>
                                        <s:elseif test="borrowStatus=='SELLER_SHIPPED'">
                                            <span id="borrowStatus<s:property value="borrowID"/>">当前状态：卖家已发货</span>
                                        </s:elseif>
                                        <s:elseif test="borrowStatus=='BUYER_NOT_RETURNED'">
                                            <span id="borrowStatus<s:property value="borrowID"/>">当前状态：买家未归还</span>
                                        </s:elseif>
                                        <s:elseif test="borrowStatus=='BUYER_RETURNED'">
                                            <span id="borrowStatus<s:property value="borrowID"/>">当前状态：买家已归还，待卖家确认</span>
                                        </s:elseif>
                                        <s:elseif test="borrowStatus=='COMPLETED'">
                                            <span id="borrowStatus<s:property value="borrowID"/>">当前状态：借阅完成</span>
                                        </s:elseif>
                                    </h4>
                                    <ul class="qty">
                                        <li><p>作者：<s:property value="author"/></p></li>
                                        <li><p>分类：<s:property value="category1"/>&nbsp;&nbsp;<s:property value="category2"/></p></li>
                                        <li><p>借阅积分：<s:property value="borrowCredit"/></p></li>
                                        <li><p>出借人：<s:property value="email"/></p></li>
                                    </ul>
                                    <div class="delivery">
                                        <s:if test="borrowStatus=='BUYER_NOTPAID'">
                                            <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="payDate<s:property value="borrowID"/>" style="display: none">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="fhDate<s:property value="borrowID"/>" style="display: none">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="borrowDate<s:property value="borrowID"/>" style="display: none">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="yhdate<s:property value="borrowID"/>" style="display: none">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnDate<s:property value="borrowID"/>" style="display: none">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="shDate<s:property value="borrowID"/>" style="display: none">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnAddr<s:property value="borrowID"/>" style="display: none">归还地址：<s:property value="returnAddress"/></p><br>
                                        </s:if>
                                        <s:if test="borrowStatus=='SELLER_NOT_SHIPPED'">
                                            <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="payDate<s:property value="borrowID"/>">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="fhDate<s:property value="borrowID"/>" style="display: none">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="borrowDate<s:property value="borrowID"/>" style="display: none">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="yhdate<s:property value="borrowID"/>" style="display: none">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnDate<s:property value="borrowID"/>" style="display: none">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="shDate<s:property value="borrowID"/>" style="display: none">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnAddr<s:property value="borrowID"/>" style="display: none">归还地址：<s:property value="returnAddress"/></p><br>
                                            <a href="#" id="deliverBorrowBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="deliverBorrowOrder(<s:property value="borrowID"/>)">发货</a>
                                            <form id="borrowDelivery<s:property value="borrowID"/>" style="display: none">
                                                <input type="text" id="trackingNO2<s:property value="borrowID"/>" name="trackingNo2" placeholder="请填写快递单号"/>
                                                <input type="text" id="returnAddr<s:property value="borrowID"/>" name="returnAddress" placeholder="请填写归还地址"/>
                                                <a href="#" class="add-cart item_add" onclick="deliverBorrowBook(<s:property value="borrowID"/>)">提交</a>
                                            </form>
                                        </s:if>
                                        <s:elseif test="borrowStatus=='SELLER_SHIPPED'">
                                            <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="payDate<s:property value="borrowID"/>">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="fhDate<s:property value="borrowID"/>">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="borrowDate<s:property value="borrowID"/>" style="display: none">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="yhdate<s:property value="borrowID"/>" style="display: none">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnDate<s:property value="borrowID"/>" style="display: none">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="shDate<s:property value="borrowID"/>" style="display: none">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnAddr<s:property value="borrowID"/>" style="display: none">归还地址：<s:property value="returnAddress"/></p><br>
                                        </s:elseif>
                                        <s:elseif test="borrowStatus=='BUYER_NOT_RETURNED'">
                                            <s:if test="delayCount==0">
                                                <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="payDate<s:property value="borrowID"/>">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                                <p id="fhDate<s:property value="borrowID"/>">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="borrowDate<s:property value="borrowID"/>">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                                <p id="yhdate<s:property value="borrowID"/>">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="returnDate<s:property value="borrowID"/>" style="display: none">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                                <p id="shDate<s:property value="borrowID"/>" style="display: none">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="returnAddr<s:property value="borrowID"/>">归还地址：<s:property value="returnAddress"/></p><br>
                                            </s:if>
                                            <s:elseif test="delayCount==1">
                                                <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="payDate<s:property value="borrowID"/>">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                                <p id="fhDate<s:property value="borrowID"/>">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="borrowDate<s:property value="borrowID"/>">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                                <p id="yhdate<s:property value="borrowID"/>">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="returnDate<s:property value="borrowID"/>" style="display: none">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                                <p id="shDate<s:property value="borrowID"/>" style="display: none">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                                <p id="returnAddr<s:property value="borrowID"/>">归还地址：<s:property value="returnAddress"/></p><br>
                                            </s:elseif>
                                        </s:elseif>
                                        <s:elseif test="borrowStatus=='BUYER_RETURNED'">
                                            <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="payDate<s:property value="borrowID"/>">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="fhDate<s:property value="borrowID"/>">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="borrowDate<s:property value="borrowID"/>">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="yhdate<s:property value="borrowID"/>">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnDate<s:property value="borrowID"/>">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                            <p id="shDate<s:property value="borrowID"/>" style="display: none">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="returnAddr<s:property value="borrowID"/>">归还地址：<s:property value="returnAddress"/></p><br>
                                            <a href="#" id="confirmReturnBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="confirmReturnReceipt(<s:property value="borrowID"/>)">确认收货</a>
                                        </s:elseif>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </s:iterator>
                    <div id="bookID1" class="cart-header">
                        <div class="cart-sec simpleCart_shelfItem">
                            <div class="cart-item cyc">
                                <img src="<%=path%>/images/m5.png" class="img-responsive" alt="">
                            </div>
                            <div class="cart-item-info">
                                <h4>
                                    <a href="<%=path%>/">订单号:1580021000037&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：未支付</a>
                                </h4><br>
                                <ul class="qty">
                                    <li><p>书名：黄政的自传</p></li>
                                    <li><p>下单时间：2017-6-10   20:42:48</p></li>
                                    <li><p>总积分：1024</p></li>
                                </ul>
                                <div class="delivery">
                                    <p>收货人：黄政&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>收货地址：东川路800号</p><br>
                                    <a href="${showOrderLink}" id="payBtn" class="add-cart item_add">支付</a>
                                    <a href="${cancelOrderLink}" id="cancelBtn" class="add-cart item_add">取消</a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div><hr>
                    <div id="bookID2" class="cart-header">
                        <div class="cart-sec simpleCart_shelfItem">
                            <div class="cart-item cyc">
                                <img src="<%=path%>/images/m5.png" class="img-responsive" alt="">
                            </div>
                            <div class="cart-item-info">
                                <h4>
                                    <a href="<%=path%>/">订单号:1580021000037&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：未发货</a>
                                </h4><br>
                                <ul class="qty">
                                    <li><p>书名：黄政的自传</p></li>
                                    <li><p>下单时间：2017-6-10   20:42:48</p></li>
                                    <li><p>总积分：524</p></li>
                                </ul>
                                <div class="delivery">
                                    <p>收货人：沈斯杰&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>收货地址：东川路800号</p><br>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div><hr>

                </div>
                <div id="lend-book-history-list">
                    <h4>已归还的图书</h4>
                    <!-- 以下迭代显示已归还的图书 -->
                    <s:iterator value="#lendBookHistoryList" status="map_state">
                        <div id="borrowHistory<s:property value="borrowID"/>" class="cart-header">
                            <div class="cart-sec simpleCart_shelfItem">
                                <div class="cart-item cyc">
                                    <img src="<%=path%>/imageAction/showImage?imageID=<s:property value="imageID"/>" class="img-responsive" alt="">
                                </div>
                                <div class="cart-item-info">
                                    <h4>
                                        <a href="<%=path%>/bookAction/showBookProfile?bookID=<s:property value="bookID"/>">
                                            书名：<s:property value="bookName"/></a><br>
                                        <span>当前状态：借阅已完成</span>
                                    </h4>
                                    <ul class="qty">
                                        <li><p>作者：<s:property value="author"/></p></li>
                                        <li><p>分类：<s:property value="category1"/>&nbsp;&nbsp;<s:property value="category2"/></p></li>
                                        <li><p>借阅积分：<s:property value="borrowCredit"/></p></li>
                                        <li><p>借书人：<s:property value="buyerEmail"/></p></li>
                                    </ul>
                                    <div class="delivery">
                                        <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <p id="payDate<s:property value="borrowID"/>">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="fhDate<s:property value="borrowID"/>">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <p id="borrowDate<s:property value="borrowID"/>">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="yhdate<s:property value="borrowID"/>">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <p id="returnDate<s:property value="borrowID"/>">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="shDate<s:property value="borrowID"/>">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="borrowAddr<s:property value="borrowID"/>">卖家地址：<s:property value="borrowAddress"/></p><br>

                                        <s:if test="comment2==null">
                                            <a href="#" id="creditRatingBtn<s:property value="bookID"/>" class="add-cart item_add" onclick="creditRating(<s:property value="borrowID"/>)">信用评价</a>
                                        </s:if>
                                        <form id="creditRatingForm<s:property value="borrowID"/>" style="display: none">
                                            <input type="hidden" name="borrowID" value="<s:property value="borrowID"/>"/>
                                            <select name="creditRating" class="form-control form-control-noNewline">
                                                <option value="-1">差评</option>
                                                <option value="0">中评</option>
                                                <option value="1">好评</option>
                                            </select>
                                            <a href="#" class="add-cart item_add" onclick="submitRating(<s:property value="borrowID"/>)">评价</a>
                                            <div id="comment_status2"></div>
                                        </form>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div><hr>
                    </s:iterator>
                    <!--
                    <div id="bookID3" class="cart-header">
                        <div class="cart-sec simpleCart_shelfItem">
                            <div class="cart-item cyc">
                                <img src="<%=path%>/images/m5.png" class="img-responsive" alt="">
                            </div>
                            <div class="cart-item-info">
                                <h4>
                                    <a href="<%=path%>/">订单号:1580021000037&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：已发货</a>
                                </h4><br>
                                <ul class="qty">
                                    <li><p>书名：黄政的自传</p></li>
                                    <li><p>下单时间：2017-6-10   20:42:48</p></li>
                                    <li><p>总积分：10240</p></li>
                                </ul>
                                <div class="delivery">
                                    <p>收货人：高仓靖博&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>收货地址：东川路800号</p><br>
                                    <p>付款时间：2017-6-10   20:42:48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>发货时间：2017-6-10   20:42:48</p><br>
                                    <a href="${confirmReceiptLink}" id="confirmBtn" class="add-cart item_add" onclick="">确认收货</a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div><hr>
                    <div id="bookID4" class="cart-header">
                        <div class="cart-sec simpleCart_shelfItem">
                            <div class="cart-item cyc">
                                <img src="<%=path%>/images/m5.png" class="img-responsive" alt="">
                            </div>
                            <div class="cart-item-info">
                                <h4>
                                    <a href="<%=path%>/">订单号:1580021000037&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：已完成</a>
                                </h4><br>
                                <ul class="qty">
                                    <li><p>书名：黄政的自传</p></li>
                                    <li><p>下单时间：2017-6-10   20:42:48</p></li>
                                    <li><p>总积分：10240</p></li>
                                </ul>
                                <div class="delivery">
                                    <p>收货人：Bjarne&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>收货地址：东川路800号</p><br>
                                    <p>付款时间：2017-6-10   20:42:48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>发货时间：2017-6-10   20:42:48</p><br>
                                    <p>收货时间：2017-6-10   20:42:48</p><br>
                                    <a href="#" id="commentBtn" class="add-cart item_add" onclick="">信用评价</a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div><hr> -->
                </div>
                <div id="sell-book-list">
                    <h4>已卖出的图书</h4>
                    <!-- 以下迭代显示已卖出的图书 -->
                    <s:iterator value="#sellBookList" status="st">
                        <div id="<s:property value="orderID"/>" class="cart-header">
                            <div class="cart-sec simpleCart_shelfItem">
                                <div class="cart-item cyc">
                                    <img src="<%=path%>/imageAction/showImage?imageID=<s:property value="coverPicture"/>" class="img-responsive" alt="">
                                </div>
                                <div class="cart-item-info">
                                    <h4>
                                        <s:if test="status=='NOTPAYED'">
                                            <p id="status<s:property value="orderID"/>">订单号：<s:property value="orderID"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：未支付</p>
                                        </s:if>
                                        <s:elseif test="status=='CANCELED'">
                                            <p id="status<s:property value="orderID"/>">订单号：<s:property value="orderID"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：已取消</p>
                                        </s:elseif>
                                        <s:elseif test="status=='NOTSHIPPED'">
                                            <p id="status<s:property value="orderID"/>">订单号：<s:property value="orderID"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：未发货</p>
                                        </s:elseif>
                                        <s:elseif test="status=='SHIPPED'">
                                            <p id="status<s:property value="orderID"/>">订单号：<s:property value="orderID"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：已发货</p>
                                        </s:elseif>
                                        <s:elseif test="status=='COMPLETED'">
                                            <p id="status<s:property value="orderID"/>">订单号：<s:property value="orderID"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：已完成</p>
                                        </s:elseif>
                                    </h4><br>
                                    <ul class="qty">
                                        <li><p>书名：<s:property value="bookName"/></p></li>
                                        <li><p>下单时间：<s:property value="orderDate"/></p></li>
                                        <li><p>总积分：<s:property value="totalCredit"/></p></li>
                                    </ul>
                                    <div class="delivery">
                                        <p>收货人：<s:property value="receiver"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <p>收货地址：<s:property value="address"/></p><br>
                                        <s:if test="status=='NOTPAYED'">
                                            <p id="payDate<s:property value="orderID"/>" style="display: none">付款时间：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="fhDate<s:property value="orderID"/>" style="display: none">发货时间：<s:property value="fhDate"/></p><br>
                                            <p id="shDate<s:property value="orderID"/>" style="display: none">收货时间：<s:property value="shDate"/></p><br>

                                            <a href="#" id="payBtn<s:property value="orderID"/>" class="add-cart item_add" onclick="payOrder(<s:property value="orderID"/>)">支付</a>
                                            <a href="#" id="cancelBtn<s:property value="orderID"/>" class="add-cart item_add" onclick="cancelOrder(<s:property value="orderID"/>)">取消</a>
                                        </s:if>
                                        <s:elseif test="status=='CANCELED'">

                                        </s:elseif>
                                        <s:elseif test="status=='NOTSHIPPED'">
                                            <p id="payDate<s:property value="orderID"/>">付款时间：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="fhDate<s:property value="orderID"/>" style="display: none">发货时间：<s:property value="fhDate"/></p><br>
                                            <p id="shDate<s:property value="orderID"/>" style="display: none">收货时间：<s:property value="shDate"/></p><br>
                                        </s:elseif>
                                        <s:elseif test="status=='SHIPPED'">
                                            <p id="payDate<s:property value="orderID"/>">付款时间：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="fhDate<s:property value="orderID"/>">发货时间：<s:property value="fhDate"/></p><br>
                                            <p id="shDate<s:property value="orderID"/>" style="display: none">收货时间：<s:property value="shDate"/></p><br>

                                            <a id="confirmOrderBtn<s:property value="orderID"/>" href="#" class="add-cart item_add" onclick="confirmOrderReceipt(<s:property value="orderID"/>)">确认收货</a>
                                        </s:elseif>
                                        <s:elseif test="status=='COMPLETED'">
                                            <p id="payDate<s:property value="orderID"/>">付款时间：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                            <p id="fhDate<s:property value="orderID"/>">发货时间：<s:property value="fhDate"/></p><br>
                                            <p id="shDate<s:property value="orderID"/>">收货时间：<s:property value="shDate"/></p><br>

                                            <a href="#" id="creditRatingBtn<s:property value="orderID"/>" class="add-cart item_add" onclick="creditRating(<s:property value="orderID"/>)">信用评价</a>
                                            <form id="creditRatingForm<s:property value="orderID"/>" action="<%=path%>/commentAction/honestyRatingWhenBuy" method="post" style="display: none">
                                                <input type="hidden" name="orderID" value="<s:property value="orderID"/>"/>
                                                <select name="creditRating" class="form-control form-control-noNewline">
                                                    <option value="-1">差评</option>
                                                    <option value="0">中评</option>
                                                    <option value="1">好评</option>
                                                </select>
                                                <a href="#" class="add-cart item_add" onclick="submitRating(<s:property value="orderID"/>)">评价</a>
                                            </form>
                                        </s:elseif>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div><hr>

                    </s:iterator>
                    <div id="bookID4" class="cart-header">
                        <div class="cart-sec simpleCart_shelfItem">
                            <div class="cart-item cyc">
                                <img src="<%=path%>/images/m5.png" class="img-responsive" alt="">
                            </div>
                            <div class="cart-item-info">
                                <h4>
                                    <a href="<%=path%>/">订单号:1580021000037&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：已完成</a>
                                </h4><br>
                                <ul class="qty">
                                    <li><p>书名：黄政的自传</p></li>
                                    <li><p>下单时间：2017-6-10   20:42:48</p></li>
                                    <li><p>总积分：10240</p></li>
                                </ul>
                                <div class="delivery">
                                    <p>收货人：Bjarne&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>收货地址：东川路800号</p><br>
                                    <p>付款时间：2017-6-10   20:42:48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>发货时间：2017-6-10   20:42:48</p><br>
                                    <p>收货时间：2017-6-10   20:42:48</p><br>
                                    <a href="#" id="commentBtn" class="add-cart item_add" onclick="">信用评价</a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div><hr>
                    <div id="bookID4" class="cart-header">
                        <div class="cart-sec simpleCart_shelfItem">
                            <div class="cart-item cyc">
                                <img src="<%=path%>/images/m5.png" class="img-responsive" alt="">
                            </div>
                            <div class="cart-item-info">
                                <h4>
                                    <a href="<%=path%>/">订单号:1580021000037&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前状态：已取消</a>
                                </h4><br>
                                <ul class="qty">
                                    <li><p>书名：黄政的自传</p></li>
                                    <li><p>下单时间：2017-6-10   20:42:48</p></li>
                                    <li><p>总积分：10240</p></li>
                                </ul>
                                <div class="delivery">
                                    <p>收货人：Bjarne&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                    <p>收货地址：东川路800号</p><br>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div><hr>
                </div>

            </div>
        </div>
    </div>
</div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>