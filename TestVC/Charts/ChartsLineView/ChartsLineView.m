////
////  ChartsLineView.m
////  ChartsTestForOC
////
////  Created by netvox-ios1 on 2017/5/3.
////  Copyright © 2017年 netvox. All rights reserved.
////
//
//#import "ChartsLineView.h"
//#import "Masonry.h"
//
////#import "ChartsTestForOC-Swift.h"
//@import Charts.Swift;
//
//
//@interface ChartsLineView ()<ChartViewDelegate>
//
////设置颜色
//@property (nonatomic, strong)NSDictionary *colors;
//
////折线图
//@property (nonatomic, strong)LineChartView *lineView;
//
//@property (nonatomic, strong)UILabel *makerLbl;//气泡显示
// 
//@end
//
//
//@implementation ChartsLineView
//
//
//
//-(instancetype)initWithFrame:(CGRect)frame andColors:(NSDictionary *)colors andBGColor:(UIColor *)color{
//    
//    self = [super initWithFrame:frame];
//    
//    _colors = colors;
//    
//    _lineView = [self setLineView];
//    [self addSubview:_lineView];
//    _lineView.backgroundColor = color;
//    _lineView.data = [self setInitLineViewData];
//    
//    
//    
//    return self;
//}
////设置折线图
//- (LineChartView *)setLineView{
//    LineChartView *line = [[LineChartView alloc] initWithFrame:self.bounds];
//    line.delegate = self;
//    line.backgroundColor = [UIColor whiteColor];
//    line.noDataText = @"暂无数据";
//    line.chartDescription.enabled = YES;
//    line.scaleYEnabled = YES;                           //默认也是打开Y轴缩放
//    line.dragEnabled = YES;                             //启用拖拽图标
//    line.dragDecelerationEnabled = YES;                  //拖拽后是否有惯性效果
//    line.dragDecelerationFrictionCoef = 0.5;            //拖拽后惯性效果的摩擦系数（0 - 1）；数值越小惯性越不明显
//    
//    //描述及图例样式
//    line.chartDescription.text = self.desp == nil ? @"" : self.desp;
//    
//    ChartLegend *legend = line.legend;
//    legend.enabled = YES;                          //在图表左下方有个图例（文字信息为ChartDataSet.init(values: dataEntries, label: "MyTestCharts") label参数值即：MyTestCharts）  默认为true
//    legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
//    legend.form = ChartLegendFormCircle;
//    
//    [line animateWithXAxisDuration:1];                  //设置动画，画线
//    
//    //设置Y轴
//    //不绘制右边轴（Y轴的右轴）
//    line.rightAxis.enabled = NO;
//    //左边Y轴
//    ChartYAxis *left = line.leftAxis;
//    left.labelCount = 10;
//    left.forceLabelsEnabled = NO;
//    left.axisMinimum = -5;
//    left.axisMaximum = 105;
//    
//    left.axisLineColor = [UIColor clearColor];
//    left.labelPosition = YAxisLabelPositionOutsideChart;    //Y轴数据显示位置
//    left.labelTextColor = [UIColor darkGrayColor];
////    left.labelFont
//    left.gridColor = [UIColor grayColor];
//    
//    //设置X轴
//    ChartXAxis *xAxis = line.xAxis;
//    xAxis.granularityEnabled = YES;
//    xAxis.labelPosition = XAxisLabelPositionBottom;
//    xAxis.gridColor = [UIColor clearColor];
//    xAxis.labelTextColor = [UIColor darkGrayColor];
//    xAxis.labelCount = 6;
//    xAxis.axisMinimum = -1;
//    xAxis.axisMaximum = 24;
//    
//    line.maxVisibleCount = 999;
//
////    line.drawMarkers = YES;
//    //显示气泡效果
//    ChartMarkerView *maker = [[ChartMarkerView alloc] init];//WithFrame:CGRectMake(0, 0, 100, 30)
//    maker.offset = CGPointMake(-25, -21);
//    maker.chartView = _lineView;
//    line.marker = maker;
//    
//    _makerLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 21)];
//    _makerLbl.font = FONT(17);
//    _makerLbl.textColor = [UIColor blackColor];
//    _makerLbl.textAlignment = NSTextAlignmentCenter;
//    [maker addSubview:_makerLbl];
//
//    
//    return line;
//}
//
////设置初始值 -- 为了网络数据未返回时，折线图能够显示  理解不深，只能先用伪数据
//-(ChartData *)setInitLineViewData{
//    _lineView.legend.enabled = NO;  //
//    NSMutableArray *entrys = [[NSMutableArray alloc] initWithCapacity:1];
//    
//    for (int i = 0; i < 25; i++) {
//        BarChartDataEntry *data = [[BarChartDataEntry alloc] initWithX:i y:-100];//-100 目前设置值最小至-5
//        [entrys addObject:data];
//    }
//    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entrys label:nil];
//    //线条 圆 圆孔(圆心)颜色
//    UIColor *clear = [UIColor clearColor];
//    set.colors = @[clear];
//    set.circleColors = @[clear];
//    set.circleHoleColor = clear;
//    
//    
//    return [[LineChartData alloc] initWithDataSets:@[set]];
//}
//
//
////设置数据
//- (ChartData *)setDataWithDatas:(NSArray *)datas{
//    
//    //打开图例样式
//    if (!_lineView.legend.enabled) {
//        _lineView.legend.enabled = YES;
//    }
//    
//    NSMutableArray *dataSets = [[NSMutableArray alloc] initWithCapacity:1];
//    
//    //线的数量
//    for (NSDictionary *type in datas) {
//        
//        NSString *typeStr = [type objectForKey:@"type"];
//        NSArray *dataArr = [type objectForKey:@"value"];
//        NSMutableArray *entrys = [[NSMutableArray alloc] initWithCapacity:1];
//        
//        for (int i = 0; i < dataArr.count; i++){
//            
//            NSDictionary *dic = dataArr[i];
//            NSString *xStr = dic[@"label"];         //时间
//            NSString *yStr = dic[@"aqi"];
//            double x = [self convertTime:xStr];
//            double y = yStr.doubleValue;
//            
//            BarChartDataEntry *data = [[BarChartDataEntry alloc] initWithX:x y:y];
//            [entrys addObject:data];
//        }
//        LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entrys label:typeStr];
//        set.drawValuesEnabled = NO; //不显示数据
//        set.circleRadius = 3;   //设置圆圈大小
//        //如果有设置颜色才修改
//        if(_colors){
//            set.colors = @[_colors[typeStr]];
//            set.circleColors = @[_colors[typeStr]];
////            NSArray *colorArr = @[_colors[i]];
////            UIColor *hole = colorArr.firstObject;
//            set.circleHoleColor = _colors[typeStr];
//        }
//        [dataSets addObject:set];
//    }
//    
//    return [[LineChartData alloc] initWithDataSets:dataSets];
//}
//-(double)convertTime:(NSString *)time{
//    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    //"2017-04-24 16:00:00"
//    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    NSDate *inputDate = [df dateFromString:time];
//    
//    int second = inputDate.timeIntervalSinceNow / 3600; //换算成小时 但为（-23 ～～ 0）
//    
//    return second + 23;
//}
//
////处理接收到的JSON数据串
//-(void)completeRequestData:(NSData *)data{
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    NSDictionary *parasDic = [dic objectForKey:@"response_params"];
//    NSArray *dataArr = [parasDic objectForKey:@"data"];
//    
//    _lineView.data = [self setDataWithDatas:dataArr];
//}
//
////测试使用，未获取网络数据，自己拼接成oc字典
//-(void)completeRequestDictionry:(NSDictionary *)dic{
//    NSDictionary *parasDic = [dic objectForKey:@"response_params"];
//    NSArray *dataArr = [parasDic objectForKey:@"data"];
//    _lineView.data = [self setDataWithDatas:dataArr];
//}
//
//
//
//#pragma mark -- 折线图的代理
//-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
//    _makerLbl.text = [NSString stringWithFormat:@"%.f", entry.y];
//}
//
//
//
//@end
