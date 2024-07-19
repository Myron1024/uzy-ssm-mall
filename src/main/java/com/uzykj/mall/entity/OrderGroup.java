package com.uzykj.mall.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

//@Data
public class OrderGroup {
//    @TableField(value = "productorder_pay_date")
    private Date productOrder_pay_date;
//    @TableField(value = "productorder_count")
    private Integer productOrder_count;
    /**
     * 订单状态
     * 0 待付款， 1 买家已付款，等待卖家发货  2 卖家已发货，等待买家确认  3 交易成功  4 交易关闭
     */
//    @TableField(value = "productorder_status")
    private Byte productOrder_status;

    public String getProductOrder_pay_date() {
        if (productOrder_pay_date != null) {
            SimpleDateFormat time = new SimpleDateFormat("MM/dd", Locale.UK);
            return time.format(productOrder_pay_date);
        }
        return null;
    }

    public void setProductOrder_pay_date(Date productOrder_pay_date) {
        this.productOrder_pay_date = productOrder_pay_date;
    }

    public Integer getProductOrder_count() {
        return productOrder_count;
    }

    public void setProductOrder_count(Integer productOrder_count) {
        this.productOrder_count = productOrder_count;
    }

    public Byte getProductOrder_status() {
        return productOrder_status;
    }

    public void setProductOrder_status(Byte productOrder_status) {
        this.productOrder_status = productOrder_status;
    }

    @Override
    public String toString() {
        return "OrderGroup{" +
                "productOrder_pay_date=" + productOrder_pay_date +
                ", productOrder_count=" + productOrder_count +
                ", productOrder_status=" + productOrder_status +
                '}';
    }
}
