//
//  UIImage+tool.m
//  testToolDemo
//
//  Created by 段贤才 on 16/6/28.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "UIImage+tool.h"

@implementation UIImage (tool)
+ (instancetype)imageWithOringalName:(NSString *)imageName{
    UIImage *img = [UIImage imageNamed:imageName];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

-(UIImage *)scaleImageToSize:(CGSize)size{
    CGSize originSize = self.size;
    CGSize realSize;
    if(originSize.height/originSize.width > size.height/size.width){/// 根据图片高度来计算
        realSize = CGSizeMake((originSize.width*size.height)/originSize.height, size.height);
    }else{
        realSize = CGSizeMake(size.width, (originSize.height*size.width)/originSize.width);
    }
    UIGraphicsBeginImageContext(CGSizeMake(realSize.width, realSize.height));
    [self drawInRect:CGRectMake(0, 0, realSize.width, realSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

- (UIImage *)imageReSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

-(UIImage *)cutImageWithRect:(CGRect)cutRect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, cutRect);
    UIGraphicsBeginImageContext(cutRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, cutRect, subImageRef);
    UIImage* cutedImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    if (subImageRef) {
        CFRelease(subImageRef);
    }
    return cutedImage;
}

+ (UIImage *)smallTheImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.);
    if (data.length > 1024*1024*2) {
        NSData *smallData = UIImageJPEGRepresentation(image, (1024*1024*2)/data.length*2);
        if (smallData.length > 1024*1024*2) {
            return [self smallTheImage:[UIImage imageWithData:smallData]];
        } else {
            return [UIImage imageWithData:smallData];
        }
    } else {
        return image;
    }
}

+ (NSData *)smallTheImageBackData:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if (data.length > 1024*1024*1) {
        NSData *smallData = UIImageJPEGRepresentation(image, (1024*1024*1)/data.length*2);
        if (smallData.length > 1024*1024*1) {
            return [self smallTheImageBackData:[UIImage imageWithData:smallData]];
        } else {
            return smallData;
        }
    } else {
        return data;
    }
}
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}
+ (UIImage *)imageFromView:(UIView*)view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(view.bounds.size);
    }
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //    CGContextSetInterpolationQuality(currnetContext, kCGInterpolationHigh);
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)saveImageToDocumentWithfolder:(NSString *)folder fileName:(NSString *)fileName{
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:folder];
    BOOL isDir = YES;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    [UIImagePNGRepresentation(self) writeToFile:filePath atomically:YES];
    return filePath;
}
- (NSString *)saveImageToCachesWithfolder:(NSString *)folder fileName:(NSString *)fileName{
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:folder];
    BOOL isDir = YES;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    [UIImagePNGRepresentation(self) writeToFile:filePath atomically:YES];
    return filePath;
}
- (NSString *)saveImageToTemporaryWithfolder:(NSString *)folder fileName:(NSString *)fileName{
    NSString *folderPath = [NSTemporaryDirectory() stringByAppendingPathComponent:folder];
    BOOL isDir = YES;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    [UIImagePNGRepresentation(self) writeToFile:filePath atomically:YES];
    return filePath;
}
/**
 二维码生成
 @param string 二维码内容
 @param size 图片宽度
 @return 二维码图片
 */
+ (UIImage *)produceRQcodeWithDataString:(NSString *)string withSize:(CGFloat) size{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = string;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.显示二维码
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
