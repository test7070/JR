<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			var q_name = "tranorde_wh_s";
			
			aPop = new Array(
				['txtDriverno', 'lblDriverno', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx']
				,['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick', 'txtCustno', 'cust_b.aspx']
                ,['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno', 'acomp_b.aspx']
				,['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']
				,['txtStraddrno', 'lblStraddrno', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b.aspx']);
				
			$(document).ready(function() {
				main();
			});
			/// end ready

			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();

				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
				q_mask(bbmMask);
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();
				$('#txtBtrandate').datepicker();
				$('#txtEtrandate').datepicker(); 
				$('#txtNoa').focus();
				
				if(q_getPara('sys.project').toUpperCase()=='SH'){
                    $('.isSH').hide();
                }
			}

			function q_seekStr() {
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				t_btrandate = $.trim($('#txtBtrandate').val());
				t_etrandate = $.trim($('#txtEtrandate').val());
				t_cno = $.trim($('#txtCno').val());
                t_acomp = $.trim($('#txtAcomp').val());
                t_custno = $.trim($('#txtCustno').val());
                t_cust = $.trim($('#txtCust').val());
                t_vccano = $.trim($('#txtVccano').val());
				
				t_noa = $.trim($('#txtNoa').val());
				t_carno = $.trim($('#txtCarno').val());
				t_po = $.trim($('#txtPo').val());
				t_straddrno = $.trim($('#txtStraddrno').val());
				t_straddr = $.trim($('#txtStraddr').val());
				
				var t_where = " 1=1 "
					+q_sqlPara2("datea", t_bdate, t_edate)
					+q_sqlPara2("trandate", t_btrandate, t_etrandate)
					+q_sqlPara2("noa", t_noa)
					+q_sqlPara2("cno", t_cno)
					+q_sqlPara2("acomp", t_acomp)
					+q_sqlPara2("addrno", t_custno)
					+q_sqlPara2("addr", t_cust)
					+q_sqlPara2("departure", t_vccano)
					
				if(t_carno.length>0)	
					t_where +=  " and exists(select noa from view_trans"+r_accy+" where view_trans"+r_accy+".noa=view_tran"+r_accy+".noa and view_trans"+r_accy+".carno='"+t_carno+"')";
				if(t_po.length>0)    
                    t_where +=  " and exists(select noa from view_trans"+r_accy+" where view_trans"+r_accy+".noa=view_tran"+r_accy+".noa and view_trans"+r_accy+".po='"+t_po+"')";
                if(t_straddrno.length>0)    
                    t_where +=  " and exists(select noa from view_trans"+r_accy+" where view_trans"+r_accy+".noa=view_tran"+r_accy+".noa and view_trans"+r_accy+".straddrno='"+t_straddrno+"')";
                if(t_straddr.length>0)    
                    t_where +=  " and exists(select noa from view_trans"+r_accy+" where view_trans"+r_accy+".noa=view_tran"+r_accy+".noa and view_trans"+r_accy+".straddr='"+t_straddr+"')";
				
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblDatea'>登錄日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr' style="display:none;">
					<td style="width:35%;" ><a id='lblTrandate'>交運日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBtrandate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEtrandate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>電腦編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr isSH'>
                    <td class='seek'  style="width:20%;"><a id='lblCno'>公司編號</a></td>
                    <td><input class="txt" id="txtCno" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr isSH'>
                    <td class='seek'  style="width:20%;"><a id='lblAcomp'>公司名稱</a></td>
                    <td><input class="txt" id="txtAcomp" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblCustno'>客戶編號</a></td>
                    <td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblCust'>客戶名稱</a></td>
                    <td><input class="txt" id="txtCust" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr isSH'>
                    <td class='seek'  style="width:20%;"><a id='lblVccano'>發票號碼</a></td>
                    <td><input class="txt" id="txtVccano" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'>車牌</a></td>
					<td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr isSH'>
                    <td class='seek'  style="width:20%;"><a id='lblPo'>聯單號碼</a></td>
                    <td><input class="txt" id="txtPo" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr isSH'>
                    <td class='seek'  style="width:20%;"><a id='lblStraddrno'>處理廠編號</a></td>
                    <td><input class="txt" id="txtStraddrno" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr isSH'>
                    <td class='seek'  style="width:20%;"><a id='lblStraddr'>處理廠</a></td>
                    <td><input class="txt" id="txtStraddr" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
