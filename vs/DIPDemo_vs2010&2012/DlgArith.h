#pragma once


// CDlgArith �Ի���

class CDlgArith : public CDialogEx
{
	DECLARE_DYNAMIC(CDlgArith)

public:
	CDlgArith(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CDlgArith();

// �Ի�������
	enum { IDD = IDD_DLG_ARITH };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	CString m_sInput;
	CString m_sEncode;
	CString m_sDecode;
	CString m_showResult;
	virtual BOOL OnInitDialog();
	afx_msg void OnBnClickedButEncode();
	void arith_Encode(const char *in, int n, double p, char *out, int &outN);
	void arith_Decode(const char *en, int n_en, double p, char *de, int n_de);
	afx_msg void OnBnClickedButDecode();
	double p;
	double m_p;
};
