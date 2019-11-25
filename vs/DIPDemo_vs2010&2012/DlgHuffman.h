#pragma once

#include "Huffman.h"
#include "afxcmn.h"
// CDlgHuffman �Ի���

class CDlgHuffman : public CDialogEx
{
	DECLARE_DYNAMIC(CDlgHuffman)

public:
	CDlgHuffman(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CDlgHuffman();
	HuffCode huffcode;
// �Ի�������
	enum { IDD = IDD_DLG_Huffman };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButtonBrInput();
	// �����ļ�·�����󶨱༭��
	CString m_inFilePath;
	// ����ļ�·�����󶨱༭��
	CString m_OutFilePath;
	afx_msg void OnBnClickedButtonEncode();
	double m_entropy;
	double m_dAverCodeLen;
	double m_rate;
	CListCtrl m_list;
	virtual BOOL OnInitDialog();
	void Update();
	afx_msg void OnBnClickedButtonDecode();
	afx_msg void OnBnClickedButtonBrOutput();
	afx_msg void OnBnClickedClose();
	double m_dCodeEff;
};

