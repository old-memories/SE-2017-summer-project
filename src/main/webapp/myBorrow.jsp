<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@include file="global.jsp"%>
<html>
<head>
    <title>myBorrow</title>
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
<script>
    function payBook(borrowID){
        var statusID = "status"+borrowID;
        var payDateID = 'payDate'+borrowID;
        var payBtnID = 'payBtn'+borrowID;
        var cancenBtnID = 'cancelBorrowBtn'+borrowID;
        $.ajax({
            url:'<%=path%>/borrowAction/confirmBorrowOrder',
            type:'POST',
            data:{'borrowIDList':borrowID},
            success:function(msg){
                if(msg.success){
                    var payDate = msg.payDate;
                    showTip('支付成功！','success');
                    $("#"+statusID).html("当前状态：卖家未发货");
                    $("#"+payBtnID).remove();
                    $("#"+cancenBtnID).remove();
                    $("#"+payDateID).html("付款日期："+payDate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#"+payDateID).show();
                }else{
                    showTip('发生错误！', 'danger');
                }
            },
            error:function(xhr,status,error){
                alert('status='+status+',error='+error);
            }
        });
    }

    function cancelBorrow(borrowID){
        var statusID = "status"+borrowID;
        var payBtnID = "payBtn"+borrowID;
        var cancelBtnID = "cancelBorrowBtn"+borrowID;
        $.ajax({
            url:'<%=path%>/borrowAction/cancelBorrowOrder',
            type:'POST',
            data:{'borrowID':borrowID},
            success:function(msg){
                if(msg.success){
                    showTip('取消成功！','success');
                    $("#"+statusID).html("当前状态：已取消");
                    $("#"+payBtnID).remove();
                    $("#"+cancelBtnID).remove();
                }else {
                    showTip('发生错误！', 'danger');
                }
            },
            error:function(xhr,status,error){
                alert('status='+status+',error='+error);
            }
        });
    }

    function confirmReceipt(borrowID){
        var confirmBtnID = "confirmBtn"+borrowID;
        var statusID = "status"+borrowID;
        var borrowDateID = "borrowDate"+borrowID;
        var returnAddrID = "returnAddr"+borrowID;
        var yhDateID = "yhdate"+borrowID;
        var returnBtnID = "returnBtn"+borrowID;
        var delayBtnID = "delayBtn"+borrowID;
        $.ajax({
            url:'<%=path%>/borrowAction/confirmBorrowReceipt',
            type:'POST',
            data:{'borrowID':borrowID},
            success:function(msg){
                if(msg.success){
                    var borrowDate = msg.borrowDate;
                    var returnAddr = msg.returnAddress;
                    var yhDate = msg.yhDate;
                    showTip('已确认收货！','success');
                    $("#"+statusID).html("当前状态：买家未归还");
                    $("#"+confirmBtnID).remove();
                    $("#"+borrowDateID).html("收货日期："+borrowDate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#"+borrowDateID).show();
                    $("#"+yhDateID).html("应还日期："+yhDate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#"+yhDateID).show();
                    $("#"+returnAddrID).html("归还地址："+returnAddr+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#"+returnAddrID).show();
                    $("#"+returnBtnID).show();
                    $("#"+delayBtnID).show();
                    //window.setTimeout("window.location='<%=path%>/borrowAction/showMyBorrow'",1500);
                }else{
                    showTip('发生错误！', 'danger');
                }
            },
            error:function(xhr,status,error){
                alert('status='+status+',error='+error);
            }
        });
    }

    function returnBook(borrowID){
        var statusID = "status"+borrowID;
        var returnBtnID = "returnBtn"+borrowID;
        var delayBtnID = "delayBtn"+borrowID;
        var returnDateID = "returnDate"+borrowID;
        var trackingNOID = "trackingNO"+borrowID;
        var trackingFormID = "tracking"+borrowID;
        var trackingNO1 = $("#"+trackingNOID).val();
        $.ajax({
            url:'<%=path%>/borrowAction/returnBook',
            type:'POST',
            data:{
                'borrowID':borrowID,
                'trackingNo1':trackingNO1,
            },
            success:function(msg){
                if (msg.success) {
                    var returnDate = msg.returnDate;
                    $("#"+statusID).html("当前状态：买家已归还，待卖家确认");
                    $("#"+returnDateID).html("归还日期："+returnDate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#"+returnDateID).show();
                    showTip('已归还图书！', 'success');
                    $("#"+returnBtnID).remove();
                    $("#"+delayBtnID).remove();
                    $("#"+trackingFormID).hide();
                }
                else {
                    showTip('发生错误！', 'danger');
                }
            },
            error:function(xhr,status,error){
                alert('status='+status+',error='+error);
            }

        });
    }

    function showReturnBook(borrowID){
        var trackingFormID = "tracking"+borrowID;
        $("#"+trackingFormID).show();
    }

    function delayBook(borrowID){
        var delayBtnID = "delayBtn"+borrowID;
        var yhdateID = "yhdate"+borrowID;
        $.ajax({
            url:'<%=path%>/borrowAction/delayBook',
            type:'POST',
            data:{
                'borrowID':borrowID
            },
            success:function(msg){
                if (msg.success) {
                    var yhdate = msg.yhdate;
                    $("#"+delayBtnID).remove();
                    $("#"+yhdateID).html("应还日期："+yhdate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    showTip('已续借图书！', 'success');

                }
                else {
                    showTip('发生错误！', 'danger');
                }
            },
            error:function(xhr,status,error){
                alert('status='+status+',error='+error);
            }

        });
    }

    function commentBook(borrowID){
        var commentFormID = "commentForm" + borrowID;
        $("#"+commentFormID).show();
    }

    function submitComment(borrowID){
        var commentID = "comment" + borrowID;
        var commentFormID = "commentForm" + borrowID;
        var commentContent = $("#"+commentID).val();
        if(commentContent.length==0){
            showTip('评论不可为空','danger');
        }else{
            $("#"+commentFormID).submit();
        }
    }

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

    $(document).ready(function(){


            //$("#borrow-book-list").hide();
            $("#borrow-book-history-list").hide();


            $("#current-tab ul").click(function(){
                $("#current-tab .single-bottom").slideToggle(300);
            });





            $("#show-borrow-book-list").click(function(){
                $("#borrow-book-list").hide();
                $("#borrow-book-history-list").hide();
                $("#borrow-book-list").show();

            });

            $("#show-borrow-book-history-list").click(function(){
                $("#borrow-book-list").hide();
                $("#borrow-book-history-list").hide();
                $("#borrow-book-history-list").show();

            });


        });
</script>

<div class="products">

    <div class="container">
        <div class="col-md-3 rsiderbar span_1_of_left">
            <section class="sky-form">
                <div class="product_right">
                    <h3 class="m_2"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span>操作选单</h3>

                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="<%=path%>/userAction/showUserProfile">个人信息</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="<%=path%>/userAction/showSellerCenter">卖家中心</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="<%=path%>/bookAction/showUserReleasedBooks">我的发布</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div id="current-tab" class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="#">我的借阅</a></li>
                            <li class="by"><span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span></li>
                        </ul>
                        <div class="clearfix"> </div>
                        <div class="single-bottom">
                            <a id="show-borrow-book-list" href="#"><p>尚未归还的图书</p></a>
                            <a id="show-borrow-book-history-list" href="#"><p>已归还的图书</p></a>
                        </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="<%=path%>/exchangeAction/showMyExchange">我的交换</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="<%=path%>/orderAction/showMyOrder">我的购买</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
                    <div class="tab1">
                        <ul class="place">
                            <li class="sort"><a href="<%=path%>/reserveAction/showMyReservation">我的预约</a></li>
                        </ul>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </section>
        </div>
        <h3 align="center">我的借阅</h3>
        <div id="tip"></div>
        <div id="cartinfo" class="cart-item">
            <div class="container">
                <!-- 以下迭代显示尚未归还的图书 -->
                <div id="borrow-book-list">
                    <h4>尚未归还的图书</h4>
                    <s:iterator value="#borrowBook" status="map_state">
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
                                        <span id="status<s:property value="borrowID"/>">当前状态：买家未付款</span>
                                    </s:if>
                                    <s:elseif test="borrowStatus=='SELLER_NOT_SHIPPED'">
                                        <span id="status<s:property value="borrowID"/>">当前状态：卖家未发货</span>
                                    </s:elseif>
                                    <s:elseif test="borrowStatus=='SELLER_SHIPPED'">
                                        <span id="status<s:property value="borrowID"/>">当前状态：卖家已发货</span>
                                    </s:elseif>
                                    <s:elseif test="borrowStatus=='BUYER_NOT_RETURNED'">
                                        <span id="status<s:property value="borrowID"/>">当前状态：买家未归还</span>
                                    </s:elseif>
                                    <s:elseif test="borrowStatus=='BUYER_RETURNED'">
                                        <span id="status<s:property value="borrowID"/>">当前状态：买家已归还，待卖家确认</span>
                                    </s:elseif>
                                    <s:elseif test="borrowStatus=='COMPLETED'">
                                        <span id="status<s:property value="borrowID"/>">当前状态：借阅完成</span>
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
                                        <a href="#" id="payBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="payBook(<s:property value="borrowID"/>)">支付</a>
                                        <a href="#" id="cancelBorrowBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="cancelBorrow(<s:property value="borrowID"/>)">取消</a>
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
                                        <a href="#" id="confirmBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="confirmReceipt(<s:property value="borrowID"/>)">确认收货</a>

                                        <a href="#" id="returnBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="showReturnBook(<s:property value="borrowID"/>)" style="display: none">归还</a>
                                        <a href="#" id="delayBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="delayBook(<s:property value="borrowID"/>)" style="display: none">续借</a>
                                        <form id="tracking<s:property value="borrowID"/>" style="display: none">
                                            <input type="text" id="trackingNO<s:property value="borrowID"/>" name="trackingNO1" placeholder="请填写快递单号"/>
                                            <a href="#" class="add-cart item_add" onclick="returnBook(<s:property value="borrowID"/>)">提交</a>
                                        </form>
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

                                            <a href="#" id="returnBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="showReturnBook(<s:property value="borrowID"/>)">归还</a>
                                            <a href="#" id="delayBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="delayBook(<s:property value="borrowID"/>)">续借</a>
                                            <form id="tracking<s:property value="borrowID"/>" style="display: none">
                                                <input type="text" id="trackingNO<s:property value="borrowID"/>" name="trackingNo1" placeholder="请填写快递单号"/>
                                                <a href="#" class="add-cart item_add" onclick="returnBook(<s:property value="borrowID"/>)">提交</a>
                                            </form>
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

                                            <a href="#" id="returnBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="showReturnBook(<s:property value="borrowID"/>)">归还</a>
                                            <form id="tracking<s:property value="borrowID"/>" style="display: none">
                                                <input type="text" id="trackingNO<s:property value="borrowID"/>" name="trackingNo1" placeholder="请填写快递单号"/>
                                                <a href="#" class="add-cart item_add" onclick="returnBook(<s:property value="borrowID"/>)">提交</a>
                                            </form>
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
                                    </s:elseif>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div><hr>
                </s:iterator>
                </div>

                <!-- 以下迭代显示已归还的图书 -->
                <div id="borrow-book-history-list">
                    <h4>已归还的图书</h4>
                    <s:iterator value="#borrowHistoryBook" status="map_state">
                        <div id="borrowHistory<s:property value="borrowID"/>" class="cart-header">
                            <div class="cart-sec simpleCart_shelfItem">
                                <div class="cart-item cyc">
                                    <img src="<%=path%>/imageAction/showImage?imageID=<s:property value="imageID"/>" class="img-responsive" alt="">
                                </div>
                                <div class="cart-item-info">
                                    <h4>
                                        <a href="<%=path%>/bookAction/showBookProfile?bookID=<s:property value="bookID"/>">
                                            书名：<s:property value="bookName"/></a><br>
                                        <s:if test="borrowStatus=='CANCELED'">
                                            <span>当前状态：已取消</span>
                                        </s:if>
                                        <s:elseif test="borrowStatus=='COMPLETED'">
                                            <span>当前状态：借阅已完成</span>
                                        </s:elseif>
                                    </h4>
                                    <ul class="qty">
                                        <li><p>作者：<s:property value="author"/></p></li>
                                        <li><p>分类：<s:property value="category1"/>&nbsp;&nbsp;<s:property value="category2"/></p></li>
                                        <li><p>借阅积分：<s:property value="borrowCredit"/></p></li>
                                        <li><p>出借人：<s:property value="email"/></p></li>
                                    </ul>
                                    <div class="delivery">
                                        <p id="orderDate<s:property value="borrowID"/>">下单日期：<s:property value="orderDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <s:if test="borrowStatus=='CANCELED'">

                                        </s:if>
                                        <s:elseif test="borrowStatus=='COMPLETED'">
                                        <p id="payDate<s:property value="borrowID"/>">付款日期：<s:property value="payDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="fhDate<s:property value="borrowID"/>">发货日期：<s:property value="fhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <p id="borrowDate<s:property value="borrowID"/>">收货日期：<s:property value="borrowDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="yhdate<s:property value="borrowID"/>">应还日期：<s:property value="yhDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <p id="returnDate<s:property value="borrowID"/>">归还日期：<s:property value="returnDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="shDate<s:property value="borrowID"/>">完成日期：<s:property value="shDate"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><br>
                                        <p id="returnAddr<s:property value="borrowID"/>">归还地址：<s:property value="returnAddress"/></p><br>


                                        <s:if test="bookComment==false">
                                            <a href="#" id="commentBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="commentBook(<s:property value="borrowID"/>)">图书评论</a>
                                        </s:if>
                                        <s:if test="comment1==null">
                                            <a href="#" id="creditRatingBtn<s:property value="borrowID"/>" class="add-cart item_add" onclick="creditRating(<s:property value="borrowID"/>)">信用评价</a>
                                        </s:if>
                                        <form id="commentForm<s:property value="borrowID"/>" style="display: none" action="<%=path%>/commentAction/commentBook" method="post">
                                            <input type="hidden" id="bookID<s:property value="bookID"/>" name="bookID" value="<s:property value="bookID"/>"/>
                                            <input type="hidden" id="borrowID<s:property value="borrowID"/>" name="borrowID" value="<s:property value="borrowID"/>"/>
                                            <textarea id="comment<s:property value="borrowID"/>" name="comment" class="form-control" rows="3"></textarea>
                                            <a href="#" class="add-cart item_add" onclick="submitComment(<s:property value="borrowID"/>)">提交</a>
                                        </form>
                                        <form id="creditRatingForm<s:property value="borrowID"/>" style="display: none" action="<%=path%>/commentAction/honestyRatingWhenBorrow">
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
                                        </s:elseif>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div><hr>
                    </s:iterator>


                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>


