// DlgArith.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "DIPDemo.h"
#include "DlgArith.h"
#include "afxdialogex.h"
#include <math.h>


// CDlgArith �Ի���

IMPLEMENT_DYNAMIC(CDlgArith, CDialogEx)

CDlgArith::CDlgArith(CWnd* pParent /*=NULL*/)
	: CDialogEx(CDlgArith::IDD, pParent)
	, m_sInput(_T(""))
	, m_sEncode(_T(""))
	, m_sDecode(_T(""))
	, m_showResult(_T(""))
	, m_p(0)
{

}

CDlgArith::~CDlgArith()
{
}

void CDlgArith::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_INPUT_, m_sInput);
	DDX_Text(pDX, IDC_EDIT_EN, m_sEncode);
	DDX_Text(pDX, IDC_EDIT_DE, m_sDecode);
	DDX_Text(pDX, IDC_STATIC_EN, m_showResult);
	DDX_Text(pDX, IDC_P, m_p);
}


BEGIN_MESSAGE_MAP(CDlgArith, CDialogEx)
	ON_BN_CLICKED(IDC_BUT_ENCODE, &CDlgArith::OnBnClickedButEncode)
	ON_BN_CLICKED(IDC_BUT_DECODE, &CDlgArith::OnBnClickedButDecode)
END_MESSAGE_MAP()


// CDlgArith ��Ϣ�������


BOOL CDlgArith::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// TODO:  �ڴ���Ӷ���ĳ�ʼ��
	m_sInput="011011101101111101110101";
	p=0.0;
	m_p=-1.0;
	UpdateData(false);
	return TRUE;  // return TRUE unless you set the focus to a control
	// �쳣: OCX ����ҳӦ���� FALSE
}


void CDlgArith::OnBnClickedButEncode()
{
	UpdateData(true);
	char *in=(LPSTR)(LPCTSTR)m_sInput;
	int n=strlen(in);
	int i;
	if(m_p>0 && m_p<1)
		p=m_p;
	else
	{	p=0.0;
		for (i=0; i<n; i++)
		{
			if (in[i]!='0' && in[i]!='1')
			{
				AfxMessageBox("ֻ������0��1��ɵĴ���");
				return;
			}
			if(in[i]=='0')
				p++;
		}
		p/=n;
	}
	char out[512];
	int outN;
	arith_Encode(in,  n, p, out, outN);
	out[outN]='\0';
	m_sEncode.Format("%s", out);
	m_showResult.Format("��������ѹ����: %f%%����", double(outN)/n*100);
	UpdateData(false);
}

void CDlgArith::OnBnClickedButDecode()
{
	UpdateData(true);
	char *en=(LPSTR)(LPCTSTR)m_sEncode;
	int n_en=strlen(en);
	if(n_en==0)
	{
		AfxMessageBox("�ȱ����ٽ��룡");
		return;
	}
	int n_de=m_sInput.GetLength();
	char de[512];
	arith_Decode(en, n_en, p, de,  n_de);
	de[n_de]='\0';
	m_sDecode.Format("%s", de);
	UpdateData(false);
}



/*******************************
void CDlgArith::arith_Encode(const char *in, int n, double p, char *out, int &outN)
���ܣ����볤Ϊn�Ķ���������in�����������out��out����ΪoutN��
������
const char *in��	����01�����硰001100110��
int n��			����01���еĳ���
double p��		0���������
char *out��		����ı�������Ҳ�Ƕ���������
int &outN��		�������ĳ���
����ֵ��
��
*******************************/
void CDlgArith::arith_Encode(const char *in, int n, double p, char *out, int &outN)
{
	if(in==NULL || n<=0)
		return ;

	double low=0.0;
	double high=1.0;
	double range=high-low;
	double low_0=0.0, high_0=p;
	double low_1=p, high_1=1.0;
	double fp=1.0;
	int i;
	for (i=0; i<n; i++)
	{
		if(in[i]=='0')
		{
			high=low + range * high_0;
			low=low + range * low_0;
			range = high - low;
			fp *= (high_0 - low_0);
		}else
		{
			high=low + range * high_1;
			low=low + range * low_1;
			range = high - low;
			fp *= (high_1 - low_1);
		}
		printf("low: %f\n",low);
	}
	outN = floor(-log10(fp)/log10(2.0))+1;
	for(i=0; i<outN; i++)
	{
		double dpi=pow(0.5, i+1);
		if (low >= dpi)
		{
			out[i] = '1';
			low -= dpi;
		}
		else
		{
			out[i]='0';
		}
	}
	// ��������,��λ
	if (low>0)
	{
		for(i=outN-1; i>=0; i--)
		{
			if(out[i]=='1')
			{
				out[i]='0';
			}else
			{
				out[i]='1';
				break;
			}
		}
	}
}

/*******************************
void CDlgArith::arith_Decode(const char *en, int n_en, double p, char *de, int n_de)
���ܣ����볤Ϊn_en�Ķ���������en������������������de��de����Ϊn_de��
������
const char *en��	����01�����硰001100110��
int n_en��		����01���еĳ���
double p��		0���������
char *de��		����Ľ�������Ҳ�Ƕ���������
int n_de��		�������ĳ���
����ֵ��
��
*******************************/
void CDlgArith::arith_Decode(const char *en, int n_en, double p, char *de, int n_de)
{
	if(en==NULL || n_en<=0 || n_de<=0)
		return ;

	double low_0=0.0, high_0=p;
	double low_1=p, high_1=1.0;

	// ���㸡����
	double f=0.0;
	int i;
	for(i=0; i<n_en; i++)
	{
		double dpi=pow(0.5, i+1);
		if (en[i]=='1')
		{
			f += dpi;
		}
	}

	// ���� 
	for (i=0; i<n_de; i++)
	{
		if(f<p) // ���0
		{
			de[i]='0';
			f = (f-low_0)/(high_0-low_0);
		}else
		{
			de[i]='1';
			f = (f-low_1)/(high_1-low_1);
		}
	}
	
}



