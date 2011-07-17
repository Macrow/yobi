#coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

puts "初始化管理员账号"
Macrow = User.create(:user_name => "Macrow", :email => "Macrow_wh@163.com", :password => "Macrow")
Macrow.update_attribute(:admin, true)
puts "成功!"

puts "======================================================"

puts "初始化产品目录"
roots = %w{会计套打账册 办公用品 金友表单 办公软件 装订产品 表单定制品 打印设备}
puts "创建 #{roots.join(' ')}"
roots = Category.create(roots.collect {|r| {:name => r} })
categories = []
categories << %w{针式账册 激光账册}
categories << %w{手写单据 装订辅助品 物流业务单据 保密工资单 存档保管}
categories << %w{U系列会计凭 L系列会计凭 K系列会计空}
categories << %w{万能票据}
categories << %w{热铆装订机 热熔装订机 热铆封套 热熔封套}
categories << %w{激光薄本账册 针式连续账册}
categories << %w{小票打印机}
roots.each_with_index do |r, i|
  if i < categories.length
    puts "创建 #{r.name} -> #{categories[i].join(' ')}"
    categories[i].each {|c| r.children.create(:name => c)}
  end
end
puts "成功!"

puts "======================================================"

puts "初始化顶层导航菜单"

puts "成功!"

puts "======================================================"

puts "初始化常用产品属性类别"
%w{大小 重量 尺寸 颜色 包装方式 封装 类别 高度 宽度 容积 容量}.each do |p|
  puts "创建 #{p}"
  Plist.create(:name => p)
end
puts "成功!"

puts "======================================================"

puts "数据初始化完成！"

