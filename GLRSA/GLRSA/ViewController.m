//
//  ViewController.m
//  GLRSA
//
//  Created by jiaguanglei on 16/1/21.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#import "ViewController.h"
#import "GLRSAUtils.h"

@interface ViewController ()<UITextViewDelegate>
// 输入字段
@property (weak, nonatomic) IBOutlet UITextView *textView;

// 显示密文
@property (weak, nonatomic) IBOutlet UILabel *privateLabel;
// 显示明文
@property (weak, nonatomic) IBOutlet UILabel *publicLabel;

// 输出密文
- (IBAction)logPrivateWords:(id)sender;
// 输出明文
- (IBAction)logPublicWords:(id)sender;


@property (copy, nonatomic) NSString *private;
@property (copy, nonatomic) NSString *public;
@property (strong, nonatomic) GLRSAUtils *rsa;
@end

@implementation ViewController

- (GLRSAUtils *)rsa
{
    if (!_rsa) {
        _rsa = [self setupRSA];
    }
    return _rsa;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textView.delegate = self;
    
    //
    

    
    
    // System.out.println the encrypt string from Java , and paste it here
    // 这里请换成你的JAVA这边产生的加密的Base64 Encode的字符串
    //        NSString* rsaEncrypyBase64 = [NSString stringWithFormat:@"%@\r%@\r%@",
    //                                      @"ZNKCVpFYd4Oi2pecLhDXHh+8kWltUMLdBIBDeTvU5kWpTQ8cA1Y+7wKO3d/M8bhULYf1FhWt80Cg",
    //                                      @"7e73SV5r+wSlgGWBvTIxqgTWFS4ELGzsEJpVVSlK1oXF0N2mugOURUILjeQrwn1QTcVdXXTMQ0wj",
    //                                      @"50GNwnHbAwyLvsY5EUY="];
    //
    //        NSString* resultString = [rsaEncryptor rsaDecryptString: rsaEncrypyBase64];
    //        NSLog(@"Decrypt Java RSA String: %@", resultString);
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text) {
        self.public = textView.text;
    }
}

- (GLRSAUtils *)setupRSA
{
    GLRSAUtils * rsaEncryptor = [[GLRSAUtils alloc] init];
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSString* privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    
    [rsaEncryptor loadPublicKeyFromFile: publicKeyPath];
    [rsaEncryptor loadPrivateKeyFromFile: privateKeyPath password:@"123456"];    // 这里，请换成你生成p12时的密码
    return rsaEncryptor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logPrivateWords:(id)sender {
    if (self.private) {
        self.private = nil;
    }
    self.private = [self.rsa rsaEncryptString:self.public];
    
    self.privateLabel.text = self.private;
    LogRed(@"Encrypted: %@", self.private);
}

- (IBAction)logPublicWords:(id)sender {
    // 请把这段字符串Copy到JAVA这边main()里做测试
    self.public = [self.rsa rsaDecryptString: self.private];
    LogRed(@"Decrypted: %@", self.public);
    self.publicLabel.text = self.public;
}
@end
