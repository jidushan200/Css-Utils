<%@ Page Title="" Language="C#" MasterPageFile="~/masterpage.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="webprj._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/js/echarts.min.js")%>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/js/echartstheme.js")%>"></script>
    <style>
        @font-face {
            font-family: YouSheBiaoTiHei;
            src: url(image/YouSheBiaoTiHei.woff2) format('woff2');
        }

        #p {
            border: 0;
            /*临时布局用*/
            /*border: 10px solid red;*/
        }

        #container {
            width: 100%;
            height: 100%;
            /*padding:5px;*/
            overflow: hidden;
            box-sizing: border-box;
            /*临时布局用*/
            /*border: 1px solid green;*/
        }

        .box {
            width: 1337px;
            height: 701px;
            overflow: hidden;
            position: relative;
            /*临时布局用*/
            /*border: 1px solid red;*/
        }

        .body_table {
            margin: 0 auto;
            width: 98%;
            height: 92.5%;
        }

        table {
            width: 100%;
            height: 100%;
            border: none;
            border-collapse: inherit;
            color: white;
            /*border-collapse:separate;*/
        }

        td {
            border-radius: 10px;
            background: #262a34;
            /*background-image: linear-gradient(#010306,#0c1429);*/
            border: 5px solid #010206;
            text-align: center;
            position: relative;
        }

        .td_title {
            position: absolute;
            top: 0;
            left: 32%;
            font-family: YouSheBiaoTiHei;
            font-size: 20px;
            font-weight: 100;
        }

            .td_title span {
                font-size: 1px;
                font-family: YouSheBiaoTiHei;
            }

        .td_min_title {
            position: absolute;
            float: right;
            top: 10px;
            left: 2%;
            font-family: YouSheBiaoTiHei;
            font-size: 10px;
            font-weight: 100;
            color: #5287c1;
        }

        .td_body {
            position: absolute;
            width: 485px;
            height: 250px;
            top: 0;
        }

        .safe_body {
            position: absolute;
            top: 40px;
            /*临时布局用*/
            /*border: 1px solid red;*/
        }

            .safe_body div {
                width: 483px;
                height: 75px;
                text-align: left;
                /*临时布局用*/
                /*border: 1px solid green;*/
            }

            .safe_body span:nth-child(odd) {
                margin-left: 5px;
                width: 100px;
                line-height: 75px;
                font-family: YouSheBiaoTiHei;
                font-weight: 100;
                font-size: 15px;
                text-shadow: 1px 0px 3px #06def2;
                /*临时布局用*/
                /*border: 1px solid blue;*/
            }

            .safe_body span:nth-child(even) {
                padding: 0 13px 0 15px;
                line-height: 75px;
                font-size: 15px;
                color: #06def2;
                background: linear-gradient(to left, #084557, #084557) left top no-repeat, linear-gradient(to bottom, #084557, #084557) left top no-repeat, linear-gradient(to left, #084557, #084557) right top no-repeat, linear-gradient(to bottom, #084557, #084557) right top no-repeat, linear-gradient(to left, #084557, #084557) left bottom no-repeat, linear-gradient(to bottom, #084557, #084557) left bottom no-repeat, linear-gradient(to left, #084557, #084557) right bottom no-repeat, linear-gradient(to left, #084557, #084557) right bottom no-repeat;
                background-color: #061826;
                background-size: 1px 5px, 5px 1px, 1px 5px, 5px 1px;
                /*临时布局用*/
                /*border: 1px solid #02454f;*/
            }

        .title_image {
            background-image: url(../image/title_bg.jpg);
            background-repeat: no-repeat;
            background-size: 100% 100%;
            padding-top: 7px;
            height: 50px;
            font-family: YouSheBiaoTiHei;
            text-align: center;
            font-size: 32px;
            font-weight: 100;
            text-shadow: 1px 0px 20px #0f7dec;
            color: white;
        }
    </style>
    <div id="p" class="easyui-panel" style="background-color: #010206" data-options="fit:true">
        <div id="container">
            <div class="box">
                <div class="title_image">
                    MEB焊装驾驶舱
                </div>
                <div class="body_table">
                    <table border="0">
                        <tr>
                            <td>
                                <div class="td_title">智慧能源<span> Smart Energy</span></div>
                                <div class="td_min_title">当日能源消耗</div>
                                <div id="main" class="td_body">
                                </div>
                            </td>
                            <td style="width: 300px">
                                <div class="td_title" style="left: 20%">智慧安全<span> Smart Security</span></div>
                                <div class="safe_body">
                                    <div>
                                        <span>安全生产天数：</span>
                                        <span>372</span>
                                        <span>温度：</span>
                                        <span>29.2 ℃</span>
                                    </div>
                                    <div>
                                        <span style="margin-left: 10px">PM2.5：</span>
                                        <span>27.0 μg</span>
                                        <span>噪音：</span>
                                        <span>54 dB</span>
                                    </div>
                                </div>

                            </td>
                            <td>
                                <div class="td_title">智慧设备<span> Smart Equipment</span></div>
                                <div id="main8" class="td_body" style="width: 300px; height: 120px; left: 30px; top: 60px">
                                </div>
                                <div id="main9" class="td_body" style="width: 300px; height: 120px; left: 180px; top: 60px">
                                </div>
                                <div class="safe_body" style="left: 320px; top: 90px;">
                                    <span style="line-height: 0px">月累计停台次数<br />
                                        (≥30分钟)</span>
                                    <br />
                                    <span style="line-height: 50px"></span>
                                    <span style="line-height: 0px">16</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="2">
                                <div class="td_title">智慧生产<span> Smart Production</span></div>
                                <div class="td_min_title">开动率</div>
                                <div id="main1" class="td_body">
                                </div>
                                <div class="td_min_title" style="top: 220px">当日累计产量</div>
                                <div id="main2" class="td_body" style="top: 200px">
                                </div>
                            </td>
                            <td rowspan="2">
                                <div class="td_title" style="left: 20%">智慧质量<span> Smart Quality</span></div>

                                <div id="main4" class="td_body" style="width: 300px; height: 120px; top: 30px; cursor: pointer;" title="点击跳转" onclick="location='<%=ResolveUrl("~/Web/QualityMap/LZHQualificationRateQuery.aspx") %>'">
                                </div>
                                <div id="main3" class="td_body" style="width: 300px; height: 120px; top: 160px;">
                                </div>
                                <div id="main5" class="td_body" style="width: 300px; height: 120px; top: 290px;">
                                </div>
                            </td>
                            <td>
                                <div class="td_title">智慧体系<span> Smart System</span></div>
                                <div id="main7" class="td_body" style="width: 130px; left: 170px">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="td_title">智慧成本<span> Smart Cost</span></div>
                                <div id="main10" class="td_body" style="width: 130px; left: 90px">
                                </div>
                                <div class="safe_body" style="left: 270px; top: 100px">
                                    <span style="line-height: 0px">当前总库存(千元)</span>
                                    <br />
                                    <span style="line-height: 50px"></span>
                                    <span style="line-height: 0px">46095</span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#p").panel({
                onResize: function () {
                    onwindowresize();
                }
            });

            //Echarts配置
            var chartDom = document.getElementById('main');
            var chartDom1 = document.getElementById('main1');
            var chartDom2 = document.getElementById('main2');
            var chartDom3 = document.getElementById('main3');
            var chartDom4 = document.getElementById('main4');
            var chartDom5 = document.getElementById('main5');
            var chartDom7 = document.getElementById('main7');
            var chartDom8 = document.getElementById('main8');
            var chartDom9 = document.getElementById('main9');
            var chartDom10 = document.getElementById('main10');

            var myChart = echarts.init(chartDom, 'line');
            var myChart1 = echarts.init(chartDom1, 'line');
            var myChart2 = echarts.init(chartDom2, 'bar');
            var myChart3 = echarts.init(chartDom3);
            var myChart4 = echarts.init(chartDom4);
            var myChart5 = echarts.init(chartDom5);
            var myChart7 = echarts.init(chartDom7, 'bar');
            var myChart8 = echarts.init(chartDom8);
            var myChart9 = echarts.init(chartDom9);
            var myChart10 = echarts.init(chartDom10, 'bar');

            //先初始化显示框架
            var option = getoption(new Array(24).fill(0), new Array(24).fill(0), new Array(24).fill(0));
            var option1 = getoption1(new Array(24).fill(0), new Array(24).fill(0), new Array(24).fill(0), new Array(24).fill(0), new Array(24).fill(0));
            var yielddata = [{ "name": "下部一UB1", "实际产量": "0" }, { "name": "下部二UB2", "实际产量": "0" }, { "name": "主焊AB", "实际产量": "0" }, { "name": "左侧围内板", "实际产量": "0" }, { "name": "右侧围内板", "实际产量": "0" }, { "name": "左侧围外板", "实际产量": "0" }, { "name": "右侧围外板", "实际产量": "0" }, { "name": "修磨Finish", "实际产量": "0" }, { "name": "左前门TVL", "实际产量": "0" }, { "name": "右前门TVR", "实际产量": "0" }, { "name": "左后门THL", "实际产量": "0" }, { "name": "右后门THR", "实际产量": "0" }, { "name": "前盖FK", "实际产量": "0" }, { "name": "后盖HK", "实际产量": "0" }]
            var option2 = getoption2(yielddata);
            var option3 = getoption3([{ "Qualified": 0 }]);
            var option4 = getoption4([{ "Qualified": 0 }]);
            var option5 = getoption5([{ "Qualified": 0 }]);
            var option7 = getoption7();
            var option8 = getoption8();
            var option9 = getoption9();
            var option10 = getoption10();

            //初始化配置
            myChart.setOption(option);
            myChart1.setOption(option1);
            myChart2.setOption(option2);
            myChart3.setOption(option3);
            myChart4.setOption(option4);
            myChart5.setOption(option5);
            myChart7.setOption(option7);
            myChart8.setOption(option8);
            myChart9.setOption(option9);
            myChart10.setOption(option10);

            //获取数据，进行赋值
            var refresh = function () {
                $.ajax({
                    type: "POST",
                    async: true,
                    url: "<%=ResolveUrl("~/WebHttpHandlers/DataQuery/DashboardQueryHandler.ashx")%>",
                    traditional: true,
                    success: function (data) {
                        jsondata = JSON.parse(data)
                        //当日能源消耗
                        var powerdata = new Array(24).fill(0);
                        var lowbardata = new Array(24).fill(0);
                        var highbardata = new Array(24).fill(0);
                        jsondata[0].forEach(function (e) {
                            if (e.tagtype == "power") {
                                powerdata[e.hour] = e.stepval;
                            }
                            if (e.tagtype == "6bar") {
                                lowbardata[e.hour] = e.stepval;
                            }
                            if (e.tagtype == "12bar") {
                                highbardata[e.hour] = e.stepval;
                            }
                        });
                        option = getoption(powerdata, lowbardata, highbardata);

                        //当日区域开动率
                        var Unterbau1 = new Array(24).fill(0);
                        var Unterbau2 = new Array(24).fill(0);
                        var Aufbau = new Array(24).fill(0);
                        var Seitenteil = new Array(24).fill(0);
                        var Anbauteil = new Array(24).fill(0);
                        jsondata[1].forEach(function (e) {
                            if (e.areacode == "Unterbau1") {
                                Unterbau1[e.hour] = e.startrate;
                            }
                            if (e.areacode == "Unterbau2") {
                                Unterbau2[e.hour] = e.startrate;
                            }
                            if (e.areacode == "Aufbau") {
                                Aufbau[e.hour] = e.startrate;
                            }
                            if (e.areacode == "Seitenteil") {
                                Seitenteil[e.hour] = e.startrate;
                            }
                            if (e.areacode == "Anbauteil") {
                                Anbauteil[e.hour] = e.startrate;
                            }
                        });
                        option1 = getoption1(Unterbau1, Unterbau2, Aufbau, Seitenteil, Anbauteil);

                        //敏捷生产
                        option2 = getoption2(jsondata[2]);

                        //点焊合格率
                        //option3 = getoption3(jsondata[3]);
                          option3 = getoption3([{ "Qualified": 99.97 }]);
                        //螺柱焊合格率
                        option4 = getoption4(jsondata[4]);

                        //涂胶合格率
                        //option5 = getoption5(jsondata[5]);
                        option5 = getoption5([{ "Qualified": 99.95 }]);
                        myChart.setOption(option);
                        myChart1.setOption(option1);
                        myChart2.setOption(option2);
                        myChart3.setOption(option3);
                        myChart4.setOption(option4);
                        myChart5.setOption(option5);
                    },
                    error: function () {
                        alert_autoClose("出错提示", "网络调用失败！", "error", 2);
                    }
                });
            }
            refresh();
            setInterval(refresh, 60000);
        });

        //当日能源消耗
        function getoption(powerdata, lowbardata, highbardata) {
            return {
                tooltip: {
                    trigger: "axis"
                },
                legend: {
                    data: ['电能(kwh)', '低气压体(m3)', '高气压体(m3)']
                },
                xAxis: {
                    type: 'category',
                    name: '小时'
                },
                yAxis: {
                    type: 'value',
                    name: '合计值',
                    axisLabel: {
                        formatter: '{value} '
                    }
                },
                series: [
                    {
                        name: '电能(kwh)',
                        data: powerdata,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(141,229,254,0.6)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(141,229,254,0.1)'
                                }
                            ])
                        }
                    },
                    {
                        name: '低气压体(m3)',
                        data: lowbardata,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(107,75,143,1)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(107,75,143,0.5)'
                                }
                            ])
                        }
                    },
                    {
                        name: '高气压体(m3)',
                        data: highbardata,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(163,128,101,1)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(163,128,101,0.1)'
                                }
                            ])
                        }
                    }
                ]
            };
        }

        //当日区域开动率
        function getoption1(Unterbau1, Unterbau2, Aufbau, Seitenteil, Anbauteil) {
            return {
                tooltip: {
                    trigger: "axis"
                },
                legend: {
                    data: ['下部一', '下部二', '主焊', '侧围', '门盖']
                },
                xAxis: {
                    type: 'category',
                    name: '小时'
                },
                yAxis: {
                    type: 'value',
                    name: '合计值',
                    axisLabel: {
                        formatter: '{value} '
                    }
                },
                series: [
                    {
                        name: '下部一',
                        data: Unterbau1,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(141,229,254,0.6)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(141,229,254,0.1)'
                                }
                            ])
                        }
                    },
                    {
                        name: '下部二',
                        data: Unterbau2,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(107,75,143,1)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(107,75,143,0.5)'
                                }
                            ])
                        }
                    },
                    {
                        name: '主焊',
                        data: Aufbau,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(163,128,101,1)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(163,128,101,0.1)'
                                }
                            ])
                        }
                    },
                    {
                        name: '侧围',
                        data: Seitenteil,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(163,128,101,1)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(163,128,101,0.1)'
                                }
                            ])
                        }
                    },
                    {
                        name: '门盖',
                        data: Anbauteil,
                        type: 'line',
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(163,128,101,1)'
                                },
                                {
                                    offset: 0.7,
                                    color: 'rgba(163,128,101,0.1)'
                                }
                            ])
                        }
                    }
                ]
            };
        }

        //敏捷生产
        function getoption2(data) {
            return {
                legend: {
                    left: '420'
                },
                tooltip: {},
                dataset: {
                    source: data
                },
                xAxis: {
                    type: 'category',
                    axisLabel: {
                        interval: 0,
                        rotate: 30
                    }
                },
                yAxis: {

                },
                series: [{
                    type: 'bar',
                    label: {
                        show: true,
                        position: 'top',
                        color: 'white'
                    }
                }]
            };
        }

        //点焊合格率
        function getoption3(data) {
            return {
                series: [
                    {
                        type: 'gauge',
                        endAngle: -270,
                        startAngle: 90,
                        color: '#20daed',
                        center: ["25%", "50%"],
                        pointer: {
                            show: false
                        },
                        progress: {
                            show: true,
                            overlap: false
                        },
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 18
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        data: [
                            {
                                value: data[0].Qualified,
                                name: '点焊合格率',
                                title: {
                                    fontSize: 20,
                                    color: '#5287c1',
                                    fontFamily: 'YouSheBiaoTiHei',
                                    offsetCenter: ['300%', '0%']
                                },
                                detail: {
                                    offsetCenter: ['0%', '0%']
                                }
                            }
                        ],
                        detail: {
                            fontSize: 13,
                            color: 'auto',
                            formatter: '{value}%',
                            fontFamily: 'YouSheBiaoTiHei'
                        }
                    }
                ]
            };
        }

        //螺柱焊合格率
        function getoption4(data) {
            return {
                series: [
                    {
                        type: 'gauge',
                        endAngle: -270,
                        startAngle: 90,
                        color: '#fbcf9a',
                        center: ["25%", "50%"],
                        pointer: {
                            show: false
                        },
                        progress: {
                            show: true,
                            overlap: false
                        },
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 18
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        data: [
                            {
                                value: data[0].Qualified,
                                name: '螺柱焊合格率',
                                title: {
                                    fontSize: 20,
                                    color: '#5287c1',
                                    fontFamily: 'YouSheBiaoTiHei',
                                    offsetCenter: ['300%', '0%']
                                },
                                detail: {
                                    offsetCenter: ['0%', '0%']
                                }
                            }
                        ],
                        detail: {
                            fontSize: 13,
                            color: 'auto',
                            formatter: '{value}%',
                            fontFamily: 'YouSheBiaoTiHei'
                        }
                    }
                ]
            };
        }

        //涂胶合格率
        function getoption5(data) {
            return {
                series: [
                    {
                        type: 'gauge',
                        endAngle: -270,
                        startAngle: 90,
                        color: '#db81fe',
                        center: ["25%", "50%"],
                        pointer: {
                            show: false
                        },
                        progress: {
                            show: true,
                            overlap: false
                        },
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 18
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        data: [
                            {
                                value: data[0].Qualified,
                                name: '涂胶合格率',
                                title: {
                                    fontSize: 20,
                                    color: '#5287c1',
                                    fontFamily: 'YouSheBiaoTiHei',
                                    offsetCenter: ['300%', '0%']
                                },
                                detail: {
                                    offsetCenter: ['0%', '0%']
                                }
                            }
                        ],
                        detail: {
                            fontSize: 13,
                            color: 'auto',
                            formatter: '{value}%',
                            fontFamily: 'YouSheBiaoTiHei'
                        }
                    }
                ]
            };
        }

        //人员管理柱形图
        function getoption6() {
            return {
                legend: {},
                tooltip: {},
                dataset: {
                    source: [
                        ['product', '应配', '实际'],
                        ['下部一', 43.3, 85.8],
                        ['下部二', 83.1, 73.4],
                        ['主焊', 86.4, 65.2]
                    ]
                },
                xAxis: { type: 'category' },
                yAxis: {},
                series: [{ type: 'bar' }, { type: 'bar' }]
            };
        }

        //人员管理饼图
        function getoption7() {
            return {
                series: [
                    {
                        type: 'gauge',
                        endAngle: -270,
                        startAngle: 90,
                        color: '#20daed',
                        center: ["50%", "40%"],
                        pointer: {
                            show: false
                        },
                        progress: {
                            show: true,
                            overlap: false
                        },
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 18
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        data: [
                            {
                                value: 97,
                                name: '当日人员出勤率',
                                title: {
                                    fontSize: 20,
                                    color: '#5287c1',
                                    fontFamily: 'YouSheBiaoTiHei',
                                    offsetCenter: ['0%', '150%']
                                },
                                detail: {
                                    offsetCenter: ['0%', '0%']
                                }
                            }
                        ],
                        detail: {
                            fontSize: 16,
                            color: 'auto',
                            formatter: '{value}%',
                            fontFamily: 'YouSheBiaoTiHei'
                        }
                    }
                ]
            };
        }

        //点检完成率
        function getoption8() {
            return {
                series: [
                    {
                        type: 'gauge',
                        endAngle: -270,
                        startAngle: 90,
                        color: '#20daed',
                        center: ["20%", "40%"],
                        pointer: {
                            show: false
                        },
                        progress: {
                            show: true,
                            overlap: false
                        },
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 18
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        data: [
                            {
                                value: 95,
                                name: '点检完成率',
                                title: {
                                    fontSize: 20,
                                    color: '#5287c1',
                                    fontFamily: 'YouSheBiaoTiHei',
                                    offsetCenter: ['0%', '140%']
                                },
                                detail: {
                                    offsetCenter: ['0%', '0%']
                                }
                            }
                        ],
                        detail: {
                            fontSize: 16,
                            color: 'auto',
                            formatter: '{value}%',
                            fontFamily: 'YouSheBiaoTiHei'
                        }
                    }
                ]
            };
        }

        //检修完成率
        function getoption9() {
            return {
                series: [
                    {
                        type: 'gauge',
                        endAngle: -270,
                        startAngle: 90,
                        color: '#fbcf9a',
                        center: ["20%", "40%"],
                        pointer: {
                            show: false
                        },
                        progress: {
                            show: true,
                            overlap: false
                        },
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 18
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        data: [
                            {
                                value: 98.2,
                                name: '检修完成率',
                                title: {
                                    fontSize: 20,
                                    color: '#5287c1',
                                    fontFamily: 'YouSheBiaoTiHei',
                                    offsetCenter: ['0%', '140%']
                                },
                                detail: {
                                    offsetCenter: ['0%', '0%']
                                }
                            }
                        ],
                        detail: {
                            fontSize: 16,
                            color: 'auto',
                            formatter: '{value}%',
                            fontFamily: 'YouSheBiaoTiHei'
                        }
                    }
                ]
            };
        }

        //成本预算饼图
        function getoption10() {
            return {
                series: [
                    {
                        type: 'gauge',
                        endAngle: -270,
                        startAngle: 90,
                        color: '#20daed',
                        center: ["50%", "40%"],
                        pointer: {
                            show: false
                        },
                        progress: {
                            show: true,
                            overlap: false
                        },
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 18
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        data: [
                            {
                                value: 81,
                                name: '当月累计记账率',
                                title: {
                                    fontSize: 20,
                                    color: '#5287c1',
                                    fontFamily: 'YouSheBiaoTiHei',
                                    offsetCenter: ['0%', '150%']
                                },
                                detail: {
                                    offsetCenter: ['0%', '0%']
                                }
                            }
                        ],
                        detail: {
                            fontSize: 16,
                            color: 'auto',
                            formatter: '{value}%',
                            fontFamily: 'YouSheBiaoTiHei'
                        }
                    }
                ]
            };
        }


        //保存DIV大小
        save_h1 = 0;
        save_w1 = 0;
        //窗体大小变化时调整缩放比例
        function divresize() {
            //return;
            h = $(".box").height().toFixed(4);
            w = $(".box").width().toFixed(4);
            h1 = $("#container").height().toFixed(4);
            w1 = $("#container").width().toFixed(4);
            if (w1 != save_w1 || h1 != save_h1) {
                //div大小有变动，保持当前大小并变换显示比例
                save_w1 = w1;
                save_h1 = h1;
                var ratioy = h1 / h;
                var ratiox = w1 / w;
                $('.box').css({
                    'transform': 'scale(' + ratiox + ', ' + ratioy + ')',
                    'transform-origin': '0 0',
                });
            }
        };
        var timer = 0;   //计时器
        function onwindowresize() {
            clearTimeout(timer);
            timer = setTimeout(divresize, 100);
        };
        window.onload = onwindowresize;
        window.onresize = onwindowresize;

        //ie不支持fill
        if (!Array.prototype.fill) {
            Object.defineProperty(Array.prototype, 'fill', {
                value: function (value) {

                    // Steps 1-2.
                    if (this == null) {
                        throw new TypeError('this is null or not defined');
                    }

                    var O = Object(this);

                    // Steps 3-5.
                    var len = O.length >>> 0;

                    // Steps 6-7.
                    var start = arguments[1];
                    var relativeStart = start >> 0;

                    // Step 8.
                    var k = relativeStart < 0 ?
                        Math.max(len + relativeStart, 0) :
                        Math.min(relativeStart, len);

                    // Steps 9-10.
                    var end = arguments[2];
                    var relativeEnd = end === undefined ?
                        len : end >> 0;

                    // Step 11.
                    var final = relativeEnd < 0 ?
                        Math.max(len + relativeEnd, 0) :
                        Math.min(relativeEnd, len);

                    // Step 12.
                    while (k < final) {
                        O[k] = value;
                        k++;
                    }

                    // Step 13.
                    return O;
                }
            });
        }

    </script>
</asp:Content>
